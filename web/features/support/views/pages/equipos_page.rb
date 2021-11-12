class EquiposPage
  include Capybara::DSL

  def create(equipo)
    # Checkpoint com timeout explicito
    page.has_css?("#equipoForm")

    upload(equipo[:thumb]) if equipo[:thumb].length > 0 # Opção só é chamada se houver uma imagem selecionada.

    find("input[placeholder$=equipamento]").set equipo[:nome] # Busca pelo input[placeholder$=equipamento] com a última palavra equipamento ($ - Última | * - Contem | ^ - Começa)
    select_cat(equipo[:categoria]) if equipo[:categoria].length > 0 # Opção é chamada apenas se tiver uma categoria selecionada.
    find("input[placeholder^=Valor]").set equipo[:preco] # Busca pelo input[placeholder^=Valor] começando com Valor

    click_button "Cadastrar"
  end

  def select_cat(cat)
    find("#category").find("option", text: cat).select_option # Busca pelo ID Category e dentro dele busca pelo filho Option setanto o valor vindo do BDD
  end

  def upload(file_name)
    thumb = Dir.pwd + "/features/support/fixtures/images/" + file_name

    find("#thumbnail input[type=file]", visible: false).set thumb # Pega a imagem dentro da varíável thumb e add no anuncio
  end
end
