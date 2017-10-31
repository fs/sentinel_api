defmodule SentinelApi.ImageClassification do
  alias SentinelApi.Image

  def start(%{"image" => image, "callback_uri" => callback_uri, "name" => name}) do
    case Image.store({image, name}) do
      {:ok, filename} ->
        IO.puts(filename)
        {:ok, filename}
      {:error, reason} ->
        IO.puts(reason)
        {:error, reason}
    end
  end
end
