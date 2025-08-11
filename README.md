Backend: Elixir/Phoenix Shader Generation API

This project is the backend service for the Text-to-Shader application. It's a simple JSON API built with Elixir and the Phoenix framework.

It exposes a single endpoint that accepts a text description, communicates with the Google Gemini LLM to generate GLSL shader code, and returns the code to the frontend client.
🚀 Live Deployment

Backend API URL: https://shader-backend.onrender.com
🛠️ How to Run Locally
Prerequisites

Before you begin, ensure you have the following installed:

    Elixir and Erlang (The installer includes both).

1. Clone & Install Dependencies

First, clone the repository and navigate into the backend project's directory to install the necessary Elixir packages.

# Navigate into the Elixir project folder
cd shader_backend

# Install dependencies
mix deps.get

2. Set Up Environment Variables

The application requires an API key to communicate with the Google Gemini LLM.

    In the root of the shader_backend folder, create a new file named .env.

    Add your API key to this file in the following format:

    GEMINI_API_KEY="YOUR_API_KEY_HERE"

This file is included in the .gitignore and will not be committed to your repository.
3. Start the Phoenix Server

Now, you can start the local Phoenix server.

# Run the server
mix phx.server

Your backend API should now be running on http://localhost:4000.
📦 Deploying to Production

This application is configured for deployment on a service like Render.
Environment Variables

For the deployed application to work, you must set the following secret environment variables in your hosting provider's dashboard:

    SECRET_KEY_BASE: A long, random string for signing session data. You can generate one locally by running mix phx.gen.secret.

    GEMINI_API_KEY: Your secret API key for the Google Gemini service.

Language Version

To ensure compatibility, create a file named elixir_buildpack.config in the root of the shader_backend folder with your specific Elixir and Erlang versions:

# elixir_buildpack.config
erlang_version=26.2.5
elixir_version=1.16.3

