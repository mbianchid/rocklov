# DRY - Don't Repeat Yourself = Não se Repita.

describe "POST /sessions" do
  context "Login com Sucesso" do
    before(:all) do
      payload = { email: "betao@hotmail.com", password: "pwd123" }
      @result = Sessions.new.login(payload)
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuario" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  #   examples = [
  #     {
  #       title: "Senha Incorreta",
  #       payload: { email: "betao@yahoo.com", password: "123456" },
  #       code: 401,
  #       error: "Unauthorized",
  #     },
  #     {
  #       title: "Usuario nao Existe",
  #       payload: { email: "404@yahoo.com", password: "123456" },
  #       code: 401,
  #       error: "Unauthorized",
  #     },
  #     {
  #       title: "Email em Branco",
  #       payload: { email: "", password: "123456" },
  #       code: 412,
  #       error: "required email",
  #     },
  #     {
  #       title: "Sem o campo Email",
  #       payload: { password: "123456" },
  #       code: 412,
  #       error: "required email",
  #     },
  #     {
  #       title: "Senha em Branco",
  #       payload: { email: "betao@yahoo.com", password: "" },
  #       code: 412,
  #       error: "required password",
  #     },
  #     {
  #       title: "Sem o campo Senha",
  #       payload: { email: "betao@yahoo.com" },
  #       code: 412,
  #       error: "required password",
  #     },
  #   ]

  examples = Helpers::get_fixture("login")

  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Sessions.new.login(e[:payload])
      end

      it "valida status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "valida id do usuario" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
