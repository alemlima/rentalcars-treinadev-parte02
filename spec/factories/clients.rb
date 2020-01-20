FactoryBot.define do
  factory :client do
    name { 'Nome Fictício' }
    trade_name { '' }
    cnpj { '000.022.222.-1' }
    cpf { '' }
    email { 'email@ficticio.com' }
    address { nil }
    type { '' }

    factory :individual_client do
      name { 'NomeFicticio' }
      type { 'IndividualClient' }
      cpf { '000.000.000' }
    end

    factory :corporate_client do
      trade_name { 'EmpresaFicticia' }
      type { 'CorporateClient' }
      cnpj { '111.111.111' }
    end
  end
end
