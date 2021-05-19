defmodule Tutorial.Emails do
  import Bamboo.Email
  use Bamboo.Phoenix, view: TutorialWeb.EmailView

  @from "test@example.com"

  def welcome_email(%{email: email}) do
    base_email()
    |> subject("Welcome!")
    |> to(email)
    |> render("welcome.html", title: "Thank you for signing up", preheader: "Thank you for signing up to the app.")
    |> premail()
  end

  def digest_email(users) do
    base_email()
    |> subject("Daily Digest")
    |> to("myself@example.com")
    |> render("daily_digest.html", title: "Daily Digest Email", users: users)
    |> premail()
  end

  defp base_email do
    new_email()
    |> from(@from)
    |> put_html_layout({TutorialWeb.LayoutView, "email.html"}) # Set default layout
    |> put_text_layout({TutorialWeb.LayoutView, "email.text"}) # Set default text layout
  end

  defp premail(email) do
    html = Premailex.to_inline_css(email.html_body)
    text = Premailex.to_text(email.html_body)

    email
    |> html_body(html)
    |> text_body(text)
  end
end