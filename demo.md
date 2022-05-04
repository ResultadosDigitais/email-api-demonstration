# Demonstração:

## Como é feita a Autenticação?
https://developers.rdstation.com/docs/autentica%C3%A7%C3%A3o

## Qual o endpoint para o envio da request e qual o formato da request?(parametros, etc..)
https://developers.rdstation.com/reference/get_platform-analytics-emails

```ruby
	require 'uri'
	require 'net/http'
	require 'openssl'

	url = URI("https://api.rd.services/platform/analytics/emails?start_date=yyyy-mm-dd&end_date=yyyy-mm-dd")

	http = Net::HTTP.new(url.host, url.port)
	http.use_ssl = true

	request = Net::HTTP::Get.new(url)
	request["Accept"] = 'application/json'
	request["Authorization"] = 'Bearer meu_token'

	response = http.request(request)
	puts response.read_body

```

## Qual o formato da response que vou receber?
JSON
```yaml #usamos aqui a tag 'yaml' apenas devido a formatação de texto do Markdown	{
		account_id: integer,
		query_date:
			{
				start_date: 'YYYY-MM-DD',
				end_date: 'YYYY-MM-DD'

			},
		emails: [ 
			{
				campaign_id: integer,
				# Id da campanha

				campaign_name: string,
				# Nome da campanha de e-mail

				send_at: date-time,
				# Data de envio do e-mail

				contacts_count:	integer,
				# Quantidade de contatos selecionados

				email_dropped_count: integer,
				# Total de e-mails descartados

				email_delivered_count: integer,
				# Total de e-mails entregues

				email_bounced_count: integer,
				# Total de e-mails de rejeitados

				email_opened_count: integer,
				# Total de aberturas únicas por lead

				email_clicked_count: integer,
				# Total de cliques únicos por lead

				email_unsubscribed_count: integer,
				# Total não inscrito

				email_spam_reported_count: integer,
				# Total reportado como spam

				email_delivered_rate: float,
				# Taxa de entrega

				email_opened_rate: float,
				# Taxa de abertura em comparação com o número de e-mails entregues

				email_clicked_rate: float,
				# Taxa de cliques em comparação com o número de e-mails entregues

				email_spam_reported_rate: float,
				# Taxa de spam em comparação com o número de e-mails entregues
			},
		]
	}
```
