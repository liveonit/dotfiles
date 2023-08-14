import { Configuration, OpenAIApi } from "openai";
import { getApiKey, getPromptOptions } from "./config.js";

const configuration = new Configuration({
  apiKey: await getApiKey(),
});
const openai = new OpenAIApi(configuration);

export class ChatGPTClient {
  async getAnswer(question: string): Promise<string> {
    const { model, maxTokens, temperature } = await getPromptOptions();

    try {
      const result = await openai.createCompletion({
        model,
        prompt: question,
        max_tokens: maxTokens,
        temperature,
      });
      return result.data.choices[0].text;
    } catch (e) {
      console.error(e?.response ?? e);
      throw e;
    }

    // @ts-ignore
  }
}
