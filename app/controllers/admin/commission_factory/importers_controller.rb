class Admin::CommissionFactory::ImportersController < Admin::BaseController
  before_action :set_crawler, only: %i(edit update destroy execute)

  def index
    @crawlers = CommissionFactoryImporter.all
  end

  def new
    @crawler = CommissionFactoryImporter.new
  end

  def create
    @crawler = CommissionFactoryImporter.new(crawler_params)

    if @crawler.save
      flash[:success] = 'Created'
      redirect_to admin_commission_factory_importers_path
    else
      flash[:danger] = "Errors: #{@crawler.errors.full_messages.to_sentence}"
      render :new
    end
  end

  def edit
  end

  def update
    if @crawler.update(crawler_params)
      flash[:success] = 'Updated'
      redirect_to admin_commission_factory_importers_path
    else
      flash[:danger] = "Errors: #{@crawler.errors.full_messages.to_sentence}"
      render :edit
    end
  end

  def destroy
    @crawler.destroy
    flash[:success] = 'Deleted'
    redirect_to admin_commission_factory_importers_path
  end

  def execute
    @crawler.commission_factory_categories.each do |commission_factory_category|
      ::CommissionFactory::ImportProductsService.new(commission_factory_category).call
    end

    flash[:success] = 'The process has been started in background. Please come back later.'
    redirect_to admin_commission_factory_importers_path
  end

  private

  def set_crawler
    @crawler = CommissionFactoryImporter.find(params[:id])
  end

  def crawler_params
    params.require(:commission_factory_importer).permit(:user_id, :csv)
  end
end
