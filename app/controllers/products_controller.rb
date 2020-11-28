class ProductsController < ApplicationController
    before_action :set_organization
    
    # GET - /products -- returns all products
    def index
        products = Product.where(organization_id: @organization.id).select([:id, :name])
        render json: products
    end

    # POST - /products -- creates new product
    def create
        product = Product.create(
            organization_id: @organization.id,
            name: params["name"]
          )

        if product.valid?
            render json: product.as_json(except: [:organization_id, :created_at, :updated_at]), status: :created
        else
            render json: product.errors, status: :bad_request
        end
    end

    # PUT - /products/:id -- updates one product
    def update
        product = Product.where(
            id: params["id"], 
            organization_id: @organization.id
        ).first

        if product != nil
            product.update(product_params)
            if product.errors.count == 0
                render json: product.as_json(except: [:organization_id, :created_at, :updated_at]), status: :ok
            else
                render json: product.errors, status: :bad_request
            end
        else
            render json: {
                error: "Could not find product id: " + params["id"]
            }
        end
    end

    # DELETE - /products/:id -- deletes the product
    def destroy
        product = Product.where(
            id: params["id"], 
            organization_id: @organization.id
        ).first
        
        if product != nil
            product.destroy
            head :ok
        else
            render json: {
                error: "Could not find product id: " + params["id"]
            }
        end
    end

    private

    def product_params
        params.require(:product).permit(:name)
    end

    def set_organization
        organization = Organization.find_by(id: params["organization_id"])
        if organization == nil
            render json: {
                error: "Could not find an organization with the id: " + params["organization_id"]
            }, status: :bad_request
        else
            @organization = organization
        end
    end
end
