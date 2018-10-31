module Api
  module V1
    class ScrapperController < ApplicationController

      # POST /api/v1/scrap
      def create
        begin

          # verifica se já existe (para atualizá-la), ou então criamos uma nova
          @pagina_web = PaginaWeb.where(url_scrap: /#{scrap_params['url']}/).first
          unless @pagina_web
            @pagina_web = PaginaWeb.new
          end

          url = scrap_params['url']
          page = MetaInspector.new(url)
          content = Nokogiri::HTML(page.to_s).at('body').text

          @pagina_web.from_page page, content, url

          if @pagina_web.save
            render json: {message: 'Página processada com sucesso!'}, status: :created
          else
            render json: @pagina_web.errors, status: :unprocessable_entity
          end
        rescue => error
          render json: 'Não foi possível ler a página', status: :internal_server_error
        end
      end

      # GET /api/v1/tickers
      def tickers
        begin
          request = RestClient.get('https://api.coinmarketcap.com/v2/ticker/', [])
          @tickers = JSON.parse(request.body)
          render json: @tickers, status: :ok
          
        rescue => error
          render json: error.to_s, status: :internal_server_error
        end
      end

      # GET /api/v1/scrap
      def search
        begin
          @paginas = PaginaWeb.fulltext_search(search_params['q'], {:return_scores => true, :max_results => 30})
          render json: @paginas, status: :ok

        rescue Mongoid::Errors::DocumentNotFound
          render json: [], status: :ok
        rescue => error
          render json: 'Houve um erro inesperado ao buscar as páginas', status: :internal_server_error
        end
      end

      private

      def search_params
        params.permit(:q)
      end

      def scrap_params
        params.permit(:url)
      end
    end
  end
end

