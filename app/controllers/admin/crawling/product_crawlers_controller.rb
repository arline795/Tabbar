class Admin::Crawling::ProductCrawlersController < Admin::BaseController
  before_action :set_crawler, only: %i(edit update destroy execute)
  before_action :set_viglink, only: %i(index new)

  def index
    @product_crawlers = ProductCrawler.where(viglink: @viglink)
  end

  def new
    @product_crawler = ProductCrawler.new(viglink: @viglink)
  end

  def create
    @product_crawler = ProductCrawler.new(product_crawler_params)

    if @product_crawler.save
      flash[:success] = 'Created'
      redirect_to admin_crawling_product_crawlers_path(viglink: @product_crawler.viglink)
    else
      flash[:danger] = "Errors: #{@product_crawler.errors.full_messages.to_sentence}"
      render :new
    end
  end

  def edit
  end

  def update
    if @product_crawler.update(product_crawler_params)
      flash[:success] = 'Updated'
      redirect_to admin_crawling_product_crawlers_path(viglink: @product_crawler.viglink)
    else
      flash[:danger] = "Errors: #{@product_crawler.errors.full_messages.to_sentence}"
      render :edit
    end
  end

  def destroy
    @product_crawler.destroy
    flash[:success] = 'Deleted'
    redirect_to admin_crawling_product_crawlers_path(viglink: @product_crawler.viglink)
  end

  def execute
    CrawlJob.perform_later(@product_crawler.id, params[:modify])
    flash[:success] = 'The process has been started in background. Please come back later.'
    redirect_to admin_crawling_product_crawlers_path(viglink: @product_crawler.viglink)
  end

  private

  def set_crawler
    @product_crawler = ProductCrawler.find(params[:id])
  end

  def set_viglink
    @viglink = params[:viglink].present? && params[:viglink] == 'true'
  end

  def product_crawler_params
    params.require(:product_crawler).permit(
      :location, :product_link_css, :load_more_css, :paginated,
      :title_css, :price_css, :description_css, :strip_css, :viglink,
      :user_id, :image_css, :image_attribute, :image_regex, :base_url, :js
    )
  end
end
