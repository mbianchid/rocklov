describe "POST /signup" do
  context "novo usuario" do
    before(:all) do
      payload = { name: "Pitty", email: "pitty@bol.com.br", password: "pwd123" }
      MongoDB.new.remove_user(payload[:email])

      @result = Signup.new.create(payload)
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuario" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  context "usuario já existe" do
    before(:all) do
      # Dado que eu tenho um novo usuário
      payload = { name: "João da Silva", email: "joao@ig.com.br", password: "pwd123" }
      MongoDB.new.remove_user(payload[:email])

      # E o email desse usuário já foi cadastrado no sistema
      Signup.new.create(payload)

      # Quando faço uma requisição para a rota /signup
      @result = Signup.new.create(payload)
    end

    it "deve retornar 409" do
      # Então deve retornar 409
      expect(@result.code).to eql 409
    end

    it "deve retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "Email already exists :("
    end
  end

  ##################################
  ## AUTOMATIZAR ESSES 3 CENÁRIOS ##
  ##################################
  # nome é obrigatório
  # email é obrigatório
  # password é obrigatório
  ##################################

  # SEM NOME
  context "nome em branco" do
    before(:all) do
      # Dado que eu tenho um novo usuário
      payload = { name: "", email: "joao@ig.com.br", password: "pwd123" }
      MongoDB.new.remove_user(payload[:email])

      # E o email desse usuário já foi cadastrado no sistema
      # Signup.new.create(payload)

      # Quando faço uma requisição para a rota /signup
      @result = Signup.new.create(payload)
    end

    it "deve retornar 412" do
      # Então deve retornar 409
      expect(@result.code).to eql 412
    end

    it "deve retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "required name"
    end
  end

  # SEM EMAIL
  context "email em branco" do
    before(:all) do
      # Dado que eu tenho um novo usuário
      payload = { name: "João da Silva", email: "", password: "pwd123" }
      MongoDB.new.remove_user(payload[:email])

      # E o email desse usuário já foi cadastrado no sistema
      # Signup.new.create(payload)

      # Quando faço uma requisição para a rota /signup
      @result = Signup.new.create(payload)
    end

    it "deve retornar 412" do
      # Então deve retornar 409
      expect(@result.code).to eql 412
    end

    it "deve retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "required email"
    end
  end

  # SEM SENHA
  context "senha em branco" do
    before(:all) do
      # Dado que eu tenho um novo usuário
      payload = { name: "João da Silva", email: "joao@ig.com.br", password: "" }
      MongoDB.new.remove_user(payload[:email])

      # E o email desse usuário já foi cadastrado no sistema
      # Signup.new.create(payload)

      # Quando faço uma requisição para a rota /signup
      @result = Signup.new.create(payload)
    end

    it "deve retornar 412" do
      # Então deve retornar 409
      expect(@result.code).to eql 412
    end

    it "deve retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "required password"
    end
  end
end
