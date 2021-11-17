# Classe das ações e elementos da página login.

class LoginPage
  include Capybara::DSL

  def open
    visit "/"
  end

  def with(email, password)
    find("input[placeholder='Seu email']").set email
    find("input[type=password]").set password
    click_button "Entrar"
  end
end

# Modelo puritano de PageObjetcs

# def campo_email
#     return find("input[placeholder='Seu email']")
# end

# def campo_senha
#     return find("input[type=password]")
# end

# def botao_entrar
#     click_button "Entrar"
# end
