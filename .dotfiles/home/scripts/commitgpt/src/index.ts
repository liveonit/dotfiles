#!/usr/bin/env node
import { execSync } from "child_process";

import enquirer from "enquirer";
import ora from "ora";

import { ChatGPTClient } from "./client.js";
import { loadPromptTemplate } from "./config_storage.js";

const debug = (...args: unknown[]) => {
  if (process.env.DEBUG) {
    console.debug(...args);
  }
};

const CUSTOM_MESSAGE_OPTION = "[write own message]...";
const spinner = ora();

let diff = "";
try {
  diff = execSync("git diff --cached").toString();
  if (!diff) {
    console.log("No changes to commit.");
    process.exit(0);
  }
  const diffLines = diff
    .split("\n")
    .filter(
      (line) =>
        (!line.match(/\-\-.*/g) &&
          !line.match(/\+\+.*/g) &&
          line.match(/^[\-\+].*/g)) ||
        line.match(/^diff.*/g)
    );
  diff = diffLines.join("\n");
} catch (e) {
  console.log("Failed to run git diff --cached");
  process.exit(1);
}

run(diff)
  .then(() => {
    process.exit(0);
  })
  .catch((e: Error) => {
    console.log("Error: " + e.message, e.cause ?? "");
    process.exit(1);
  });

async function run(diff: string) {
  if (diff.length > 1200 * 4) {
    console.log(`Diff is way too bug. Truncating to 1200 tokens. It may help`);
    // Truncate approximating that a token is 4 characters
    diff = diff.slice(0, 1200 * 4);
  }

  const api = new ChatGPTClient();

  const prompt = loadPromptTemplate().replace(
    "{{diff}}",
    ["```", diff, "```"].join("\n")
  );

  debug("prompt: ", prompt);
  const { choices, summary } = await getMessages(api, prompt);
  console.log({ choices, summary });
  // try {
  //   const answer = await enquirer.prompt<{ message: string }>({
  //     type: "select",
  //     name: "message",
  //     message: "Pick a message",
  //     choices,
  //   });

  //   if (answer.message === CUSTOM_MESSAGE_OPTION) {
  //     execSync("git commit", { stdio: "inherit" });
  //     return;
  //   } else {
  //     execSync(`git commit -m '${escapeCommitMessage(answer.message)}'`, {
  //       stdio: "inherit",
  //     });
  //     return;
  //   }
  // } catch (e) {
  //   console.log("Aborted.");
  //   console.log(e);
  //   process.exit(1);
  // }
}

async function getMessages(api: ChatGPTClient, request: string) {
  spinner.start("Asking ChatGPT 🤖 for commit messages...");

  // send a message and wait for the response
  try {
    const response = await api.getAnswer(request);
    // find json array of strings in the response
    const commitMessages = response
      .split("\n")
      .filter(
        (l) => l.length > 1 && l.trim().match(/[a-zA-Z]+\([a-zA-z]+\)\:.*/g)
      )
      .map(normalizeMessage);

    const summary = response.match(/Changes summary:.*/gs);
    spinner.stop();

    debug("response: ", response);

    // messages.push(CUSTOM_MESSAGE_OPTION);
    return { choices: commitMessages, summary };
  } catch (e) {
    spinner.stop();
    if (e.message === "Unauthorized") {
      return getMessages(api, request);
    } else {
      throw e;
    }
  }
}

function normalizeMessage(line: string) {
  return line
    .trim()
    .replace(/^(\d+\.|-|\*)\s+/, "")
    .replace(/^[`"']/, "")
    .replace(/[`"']$/, "")
    .replace(/[`"']:/, ":") // sometimes it formats messages like this: `feat`: message
    .replace(/:[`"']/, ":") // sometimes it formats messages like this: `feat:` message
    .replace(/\\n/g, "")
    .trim();
}

function escapeCommitMessage(message: string) {
  return message.replace(/'/, `''`);
}
