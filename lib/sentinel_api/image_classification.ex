defmodule SentinelApi.ImageClassification do
  alias SentinelApi.Image

  def start(%{"image" => image, "callback_uri" => callback_uri, "name" => name}) do
    case Image.store({image, name}) do
      {:ok, filename} ->
        IO.puts(filename)

        start_learning
        {:ok, filename}
      {:error, reason} ->
        IO.puts(reason)

        {:error, reason}
    end
  end

  defp start_learning do
    System.cmd(
      "#{priv_dir}/learn",
      [4, "/root/openface", "#{app_dir}/uploads/users", "#{app_dir}/uploads/users_aligned", "#{app_dir}/uploads/feature"],
      stderr_to_stdout: true
    )
  end

  defp app_dir do
    Application.app_dir(:sentinel_api)
  end

  defp priv_dir do
    Application.app_dir(:sentinel_api, "priv")
  end
end
