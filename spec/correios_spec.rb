require "spec_helper"
require "json-schema"
require "json"
require "httparty"

class TestParty
  include HTTParty
  base_uri 'https://viacep.com.br/ws'
end

describe 'Cep correios' do

#### resposta exemplo
#   {
#   "cep": "04113-900",
#   "logradouro": "Rua do Cristal",
#   "complemento": "59/62",
#   "bairro": "Vila Mariana",
#   "localidade": "São Paulo",
#   "uf": "SP",
#   "unidade": "",
#   "ibge": "3550308",
#   "gia": "1004"
# }

  schema = {
      "type"=>"object",
      "required" => ["cep"],
      "properties" => {
        "cep" => {"type" => "string"},
        "logradouro" => {"type" => "string"},
        "complemento" => {"type" => "string"},
        "bairro" => {"type" => "string"},
        "localidade" => {"type" => "string"},
        "uf" => {"type" => "string"},
        "unidade" => {"type" => "string"},
        "ibge" => {"type" => "string"},
        "gia" => {"type" => "string"}
      }
    }

  it "validar schema de cep dos correios" do
    response = TestParty.get('/04113900/json/')
    bool = JSON::Validator.validate(schema, response.body)
    expect(bool).to be true
  end
end
