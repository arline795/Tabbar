class Admin::ProxiesController < Admin::BaseController
  before_action :set_proxy, only: %i(edit update destroy)

  def index
    @proxies = Proxy.all
  end

  def new
    @proxy = Proxy.new
  end

  def create
    @proxy = Proxy.new(proxy_params)

    if @proxy.save
      flash[:success] = 'Created'
      redirect_to admin_proxies_path
    else
      flash[:danger] = "Errors: #{@proxy.errors.full_messages.to_sentence}"
      render :new
    end
  end

  def edit
  end

  def update
    if @proxy.update(proxy_params)
      flash[:success] = 'Updated'
      redirect_to admin_proxies_path
    else
      flash[:danger] = "Errors: #{@proxy.errors.full_messages.to_sentence}"
      render :edit
    end
  end

  def destroy
    @proxy.destroy
    flash[:success] = 'Deleted'
    redirect_to admin_proxies_path
  end

  private

  def set_proxy
    @proxy = Proxy.find(params[:id])
  end

  def proxy_params
    params.require(:proxy).permit(:ip, :port, :user, :password, :user_agent)
  end
end
