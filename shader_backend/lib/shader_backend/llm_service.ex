defmodule ShaderBackend.LLMService do
  use Tesla
  plug Tesla.Middleware.JSON

@gemini_api_url "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent"
  def generate_shader_code(prompt) do
    api_key = Application.get_env(:shader_backend, :gemini_api_key)

    full_prompt = """
Generate a complete GLSL fragment shader compatible with WebGL1 (GLSL ES 1.00) for: "#{prompt}".
IMPORTANT: Your entire response must be ONLY the raw GLSL code itself.
Do not include any version directives like #version 300 es.
Do not include any other text, explanations, or markdown code fences.
"""

    body = %{ "contents" => [%{ "parts" => [%{"text" => full_prompt}]}]}

    case post(@gemini_api_url <> "?key=#{api_key}", body) do
      {:ok, response} ->
        shader_code = get_in(response.body, ["candidates", Access.at(0), "content", "parts", Access.at(0), "text"])
        
        # Clean the output before sending it
        cleaned_code = clean_shader_code(shader_code)
        {:ok, cleaned_code}

      {:error, reason} ->
      
        {:error, "Failed to connect to LLM service: #{inspect(reason)}"}
    end
  end


defp clean_shader_code(nil), do: nil
defp clean_shader_code(code) do
  code
  |> String.trim()
  |> String.replace("```glsl", "")
  |> String.replace("```", "")
  |> String.replace("#version 300 es", "") # <-- ADD THIS LINE
  |> String.trim()
end
end