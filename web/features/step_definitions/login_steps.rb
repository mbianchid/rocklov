# Acesso a página de Login
Dado("que acesso a página principal") do
  @login_page.open
end

#Acessando a página de login através da classe LoginPage
Quando("submeto minhas credenciais com {string} e {string}") do |email, password|
  @login_page.with(email, password)
end
