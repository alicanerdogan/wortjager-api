defmodule Wortjager.Statistics do
  import Ecto.Query, warn: false

  alias Wortjager.Scorecard.Answer
  alias Wortjager.Repo

  @doc """
  Gets statistics
  """
  def get_statistics(user) do
    %{ weekly: %{ percentage: get_weekly_statistics(user) }}
  end

  defp get_weekly_statistics(%{id: user_id}) do
    query = from a in Answer,
      where: a.inserted_at < from_now(1, "week") and a.user_id == ^user_id,
      select: a.result
    Repo.all(query)
    |> get_correctness_percentage
  end

  defp get_correctness_percentage(results) when length(results) == 0, do: nil
  defp get_correctness_percentage(results) do
    correct_result_count = Enum.count(results, fn(result) -> result end)
    (correct_result_count / Enum.count(results)) * 100
    |> Float.round
  end
end
