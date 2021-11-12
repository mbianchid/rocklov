require "mongo"

# Configuração para gravar os logs de acesso ao banco em arquivo separado (Pasta LOGS) e não saida do Cucumber
Mongo::Logger.logger = Logger.new("./logs/mongo.log")

# Metodo para limpar base de dados de e-mail antes de efetuar o cadastro
class MongoDB
  attr_accessor :client, :users, :equipos

  def initialize
    @client = Mongo::Client.new("mongodb://rocklov-db:27017/rocklov") # Acessa o banco de dados
    @users = client[:users] # Conectar na coleção Usuários (registro onde consta todos os usuários cadastrados)
    @equipos = client[:equipos] # Conectar na coleção Equipamentos (registro onde consta todos os equipos cadastrados)
  end

  def drop_danger
    client.database.drop
  end

  def insert_users(docs)
    @users.insert_many(docs)
  end

  # Método Remove Usuário
  def remove_user(email)
    @users.delete_many({ email: email }) # Apaga o e-mail específico antes de criar o cadastro.
  end

  def get_user(email) # Método para pegar o ID do usuário através do e-mail
    user = @users.find({ email: email }).first
    return user[:_id]
  end

  # Método que remove equipamento do usuaŕio da massa de dados
  def remove_equipo(name, user_id)
    obj_id = BSON::ObjectId.from_string(user_id)
    @equipos.delete_many({ name: name, user: obj_id }) # Apaga equipamento específico antes de criar o cadastro.
  end

  def get_mongo_id
    return BSON::ObjectId.new
  end
end
