defmodule JwtRevocationRulesElixir.Condition do
  alias __MODULE__

  @spec __struct__ :: %Condition{operation: atom(), value: any()}
  @doc """
  Represents a condition that a claim's value may meet
  """
  @enforce_keys [:operation, :value]
  defstruct [:operation, :value]

  @spec is_met(%JwtRevocationRulesElixir.Condition{}, any()) :: boolean()
  @doc """
  Returns whether `condition` is met by the `value` from the claim
  """
  def is_met(condition, value)

  def is_met(%Condition{operation: :=, value: condition_value}, claim_value)  do
    condition_value == claim_value
  end

  def is_met(%Condition{operation: :!=, value: condition_value}, claim_value) do
    condition_value != claim_value
  end
end
