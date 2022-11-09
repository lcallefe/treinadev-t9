require 'rails_helper'

describe Warehouse do 
  context '.all' do 
    it 'deve listar todos os galpões' do 
      json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
      fake_response = double("faraday_response", status:200, body:json_data)

      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

      result = Warehouse.all 

      expect(result.length).to eq 2 
      expect(result.id).to eq 1 
      expect(result[0].name).to eq 'Aeroporto SP' 
      expect(result[0].code).to eq 'GRU' 
      expect(result[0].city).to eq 'Guarulhos' 
      expect(result[0].area).to eq 100000
      expect(result[0].cep).to eq '15000-000' 
      expect(result[0].description).to eq 'Galpão destinado para cargas internacionais' 
      expect(result[1].name).to eq 'Galpao Maceio' 
      expect(result[1].code).to eq 'MCZ' 
    end

    it 'deve retornar vazio se a API estiver indisponível' do 

      fake_response = double("faraday_resp", status:500, body:"{'error':'Erro ao obter dados'}")
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

      result = Warehouse.all

      expect(result).to eq []
    end
  end
end