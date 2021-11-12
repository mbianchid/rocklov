# Validação da área logada
Então("sou redirecionado para o Dashboard") do
  expect(@dash_page.on_dash?).to be true
end

# Validação das mensagens de Alerta com o texto que vem da documentação | Modelo PageObjetcs (login_page.rb)
Então("vejo a mensagem de alerta: {string}") do |expect_alert|
  expect(@alert.dark).to eql expect_alert
end
