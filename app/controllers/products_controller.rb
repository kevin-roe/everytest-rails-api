class ProductsController < ApplicationController
    include CurrentOrganizationConcern
    include ForeignKeyConstraintConcern
    before_action :find_product, only: [:update, :destroy]
    
    # GET - /products/:organization_id -- returns all products
    def index
        products = Product
                        .where(organization_id: @organization.id)
                        .select([:id, :name])
                        .order(:id)

        render json: products
    end

    # POST - /products/:organization_id -- creates new product
    def create
        product = Product.new(
            organization_id: @organization.id,
            name: params["name"]
          )

        if product.save!
            render json: product.as_json(except: [:organization_id, :created_at, :updated_at]), status: :created
        else
            render json: product.errors, status: :bad_request
        end
    end

    # PUT - /products/:organization_id/:id -- updates one product
    def update
        @product.update(product_params)
        if @product.errors.count == 0
            render json: @product.as_json(except: [:organization_id, :created_at, :updated_at]), status: :ok
        else
            render json: @product.errors, status: :bad_request
        end
    end

    # DELETE - /products/:organization_id/:id -- deletes the product
    def destroy
        @product.destroy
        head :ok
    end

    private

    def product_params
        params.require(:product).permit(:name)
    end


    def find_product
        @product = Product.find_by(
            id: params["id"], 
            organization_id: @organization.id
        )

        if @product == nil
            head :not_found
        end
    end
end
