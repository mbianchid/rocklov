class SignupPage
  include Capybara::DSL

  def open
    visit "/signup"
  end

  def create(user)
    find("#fullName").set user[:nome] # Pega o valor da coluna Nome
    find("#email").set user[:email] # Pega o valor da coluna Email
    find("#password").set user[:senha] # Pega o valor da coluna Senha

    click_button "Cadastrar"
  end
end
