defmodule WortjagerWeb.SessionView do
  use WortjagerWeb, :view

  def render("login.json", %{jwt: jwt, exp: exp}) do
      %{jwt: jwt, exp: exp}
  end
end
