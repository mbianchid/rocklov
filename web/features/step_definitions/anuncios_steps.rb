# Acessar a área logada com o perfil informando no BDD
Dado("Login com {string} e {string}") do |email, password|
  @email = email
  # Chama a classe LoginPage
  @login_page.open
  @login_page.with(email, password)

  # Confirmação de Dashboard
  expect(@dash_page.on_dash?).to be true
end

# Criar novo anúncio
Dado("que acesso o formulário de cadastro de anuncios") do
  @dash_page.goto_equipo_form
end

# Cadastro de anuncio | Montar a massa de teste
Dado("que eu tenho o seguinte equipamento:") do |table|
  @anuncio = table.rows_hash
  # Metodo Remove_Equipo para deletar o equipamento do usuário da massa de teste.
  MongoDB.new.remove_equipo(@anuncio[:nome], @email)
end

#Preencher e submeter formulário com base na massa de teste
Quando("submeto o cadastro desse item") do
  @equipos_page.create(@anuncio)
end

# Validação anúnico com base na massa de teste.
Então("devo ver esse item no meu Dashboard") do
  expect(@dash_page.equipo_list).to have_content @anuncio[:nome]
  expect(@dash_page.equipo_list).to have_content "R$#{@anuncio[:preco]}/dia"
end

Então("deve conter a mensagem de alerta: {string}") do |expect_alert|
  expect(@alert.dark).to have_text expect_alert
end

# REMOVENDO ANÚNICOS

Dado("que eu tenho um anúncio indesejado:") do |table|
  user_id = page.execute_script("return localStorage.getItem('user')")

  thumbnail = File.open(File.join(Dir.pwd, "features/support/fixtures/images", table.rows_hash[:thumb]), "rb")

  @equipo = {
    thumbnail: thumbnail,
    name: table.rows_hash[:nome],
    category: table.rows_hash[:categoria],
    price: table.rows_hash[:preco],
  }

  EquiposServices.new.create(@equipo, user_id)

  visit current_path
end

Quando("eu solicito a exclusão desse item") do
  @dash_page.request_removal(@equipo[:name])
  sleep 1 # Thinking time
end

Quando("confirmo a exclusão") do
  @dash_page.confirm_removal
end

Quando("não confirmo a solicitação") do
  @dash_page.cancel_removal
end

Então("não devo ver esse item no meu Dashboard") do
  expect(
    @dash_page.has_no_equipo?(@equipo[:name])
  ).to be true
end

Então("esse item deve permanecer no meu Dashboard") do
  expect(@dash_page.equipo_list).to have_content @equipo[:name]
end
