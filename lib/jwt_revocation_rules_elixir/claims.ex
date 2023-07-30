defmodule JwtRevocationRulesElixir.Claims do
  @spec __struct__ :: %JwtRevocationRulesElixir.Claims{
          aud: [String.t()] | nil,
          exp: integer() | nil,
          iat: integer() | nil,
          iss: String.t() | nil,
          jti: String.t() | nil,
          nbf: integer() | nil,
          sub: String.t() | nil
        }
  @doc """
  Structure for storing the claim values to evaluate against Rules
  """
  defstruct [:iss, :sub, :aud, :exp, :nbf, :iat, :jti]
end
