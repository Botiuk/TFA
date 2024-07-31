class AtributesController < ApplicationController
    before_action :authenticate_user!, except: %i[ index show ]
    before_action :set_atribute, only: %i[ edit update show destroy ]
    authorize_resource

    def index
        if user_signed_in? && current_user.role != "user"
            @pagy, @atributes = pagy(Atribute.all.order(avaliable: :asc, name: :asc), limit: 5)
        else
            @pagy, @atributes = pagy(Atribute.where(avaliable: "present").order(name: :asc), limit: 5)
        end
    rescue Pagy::OverflowError
        redirect_to atributes_url(page: 1)
    end

    def new
        @atribute = Atribute.new
    end

    def create
        @atribute = Atribute.new(atribute_params)
        if @atribute.save
            redirect_to atribute_url(@atribute), notice: t('notice.create.atribute')
        else
            render :new, status: :unprocessable_entity
        end
    end

    def show
    end

    def edit
    end

    def update
        if @atribute.update(atribute_params)
            redirect_to atribute_url(@atribute), notice: t('notice.update.atribute')
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @atribute.destroy
        redirect_to atributes_url, notice: t('notice.destroy.atribute')
    end

    private

    def set_atribute
        @atribute = Atribute.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to atributes_url
    end

    def atribute_params
        params.require(:atribute).permit(:name, :price, :avaliable, atribute_photos: [])
    end
end
