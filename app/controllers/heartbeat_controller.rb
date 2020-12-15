class HeartbeatController < ApplicationController
    def show
        render json: {status: "up"}
    end
end