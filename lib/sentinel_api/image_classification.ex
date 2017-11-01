defmodule SentinelApi.ImageClassification do
  alias SentinelApi.Image

  def start(%{"image" => image, "callback_uri" => callback_uri, "name" => name}) do
    case name do
      "_" ->
        case Image.store({image}) do
          {:ok, filename} ->
            IO.puts(filename)

            result = start_prediction
            {:ok, result}
          {:error, reason} ->
            IO.puts(reason)

            {:error, reason}
        end
      _ ->
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
  end

  defp start_learning do
    System.cmd(
      "#{priv_dir}/learn",
      ["4", "/home/deploy/openface", "#{common_dir}/uploads"],
      stderr_to_stdout: true
    )
  end

  defp start_prediction do
    System.cmd(
      "#{priv_dir}/predict",
      ["/home/deploy/openface", "#{common_dir}/uploads"],
      stderr_to_stdout: true
    )
  end

  defp app_dir do
    Application.app_dir(:sentinel_api)
  end

  defp priv_dir do
    Application.app_dir(:sentinel_api, "priv")
  end

  defp common_dir do
    "/home/deploy/sentinel_api"
  end
end
