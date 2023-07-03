import { $, fetch, path } from 'zx'

$.verbose = false


const MAX_TOKEN_COUNT = {
  "gpt-4": 8192,
  "gpt-3.5-turbo": 4097,
  "text-davinci-003": 2096
}

const fetchDavinci = async (prompt: string, engine: keyof typeof MAX_TOKEN_COUNT = 'text-davinci-003') => {
  const result = await fetch(`https://api.openai.com/v1/engines/${engine}/completions`, {
    method: 'post',
    body: JSON.stringify({
      prompt,
      "max_tokens": MAX_TOKEN_COUNT[engine],
      "temperature": 0.7
    }),
    headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${process.env.token}` }
  })
  const data: any = await result.json()
  return data?.["choices"]?.[0].text as string
}

const diffResult = await $`git diff --staged --name-only`
const filesChanged = diffResult.stdout.split('\n').filter(diff => diff.length)

if (filesChanged.length) {
  const rootGitDir = (await $`git rev-parse --show-toplevel`).stdout.trim()
  const fileChangesQuestios = await Promise.all(filesChanged.map(async (file) => {
    const filePath = path.resolve(rootGitDir, file)
    const fileDiffResult = await $`git  --no-pager diff --staged -- ${filePath}`
    return `Use concise language. Dont repeat yourself. Use short sentences.
Create a bullet point summary of the changes made to the file ${file} on the current git commit
from its "git diff" output. Please avoid printing back sensitive information like the values
of environment variables, or passwords. Any bullet point should not end with a comma or period.

Include the name of the file in the summary as the heading. For example:

"""
Changes to file $file:
- ...
- ...

Changes to file $file:
- ...
- ...

"""

Git Diff:
${fileDiffResult}
`
  }))

  if (fileChangesQuestios.length) {
    const responses = (await Promise.all(fileChangesQuestios.map(question => fetchDavinci(question)))).filter(res => !!res)

    const prompt = `
  Create a brief summary using a single paragraph with no more than 600 characters, describing all the main changes done
  since the last git commit from the following List of changes. Also, the first line must
  be a "Semantic Commit Message" that describes the changes in a single line of no more than
  80 characters and ending with a related emoji, add a new empty line between the semantic message.
  The semantic commit must not be longer than 80 characters.
  You MUST separate the semantic commit from the summary paragraph with a new line.

  Examples of semantic message:

  """
  feat: add support for GPT-3 ⚙️

  fix: fix bug in the google-credentials.sh script 🔐

  chore: update the aws.sh script ☁️
  """

  List of changes:

  """
  ${responses}
  """
  `
    const result = await fetchDavinci(prompt)
    console.log(`${result}

List of changes: ${responses}
`)
  }
}





