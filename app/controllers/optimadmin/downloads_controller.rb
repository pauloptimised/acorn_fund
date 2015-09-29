module Optimadmin
  class DownloadsController < Optimadmin::ApplicationController
    before_action :set_download, only: [:show, :edit, :update, :destroy]

    def index
      @downloads = Optimadmin::BaseCollectionPresenter.new(collection: Download.where('title ILIKE ?', "%#{params[:search]}%").page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::DownloadPresenter)
    end

    def show
    end

    def new
      @download = Download.new
    end

    def edit
    end

    def create
      @download = Download.new(download_params)
      if @download.save
        redirect_to downloads_url, notice: 'Download was successfully created.'
      else
        render :new
      end
    end

    def update
      if @download.update(download_params)
        redirect_to downloads_url, notice: 'Download was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @download.destroy
      redirect_to downloads_url, notice: 'Download was successfully destroyed.'
    end

  private


    def set_download
      @download = Download.find(params[:id])
    end

    def download_params
      params.require(:download).permit(:title, :file, :file_cache, :remove_file, :remote_file_url)
    end
  end
end
