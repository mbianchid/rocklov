#Acessar a página de cadastro
Dado("que acesso a página de cadastro") do
  @signup_page.open
end

# Preenchimento dos campos de cadastro
Quando("submeto o seguinte formulário de cadastro:") do |table|
  user = table.hashes.first #Converter a tabela em um Array
  MongoDB.new.remove_user(user[:email]) # Chamando a classe MongoDB para efetuar a limpeza do Banco para efetuar o cadastro (Arquivo -> libs/mongo.rb)

  @signup_page.create(user)
end
