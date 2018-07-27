class LinksController < ApplicationController

  def index
    @links = Link.all
  end

  def display_list
    @links = Link.all.order(:display_order)
    render layout: false
  end

  def code_scan
    @links = Link.all.order(:display_order)
    render layout: false
  end

  def phone_number
    # @users = RedisService.new.get_value(:users)
    # if @users.blank?
    #   @users = User.all
    #   RedisService.new.set_value(:users,@users)
    # end
    render layout: false
  end


  def display_icon
    @icons = %w(icon-glass icon-music icon-search icon-envelope icon-heart icon-star icon-star-empty icon-user icon-film icon-th-large icon-th icon-th-list icon-ok icon-remove icon-zoom-in icon-zoom-out icon-off icon-signal icon-cog icon-trash icon-home icon-file icon-time icon-road icon-download-alt icon-download icon-upload icon-inbox icon-play-circle icon-repeat icon-refresh icon-list-alt icon-lock icon-flag icon-headphones icon-volume-off icon-volume-down icon-volume-up icon-qrcode icon-barcode icon-tag icon-tags icon-book icon-bookmark icon-print icon-camera icon-font icon-bold icon-italic icon-text-height icon-text-width icon-align-left icon-align-center icon-align-right icon-align-justify icon-list icon-indent-left icon-indent-right icon-facetime-video icon-picture icon-pencil icon-map-marker icon-adjust icon-tint icon-edit icon-share icon-check icon-move icon-step-backward icon-fast-backward icon-backward icon-play icon-pause icon-stop icon-forward icon-fast-forward icon-step-forward icon-eject icon-chevron-left icon-chevron-right icon-plus-sign icon-minus-sign icon-remove-sign icon-ok-sign icon-question-sign icon-info-sign icon-screenshot icon-remove-circle icon-ok-circle icon-ban-circle icon-arrow-left icon-arrow-right icon-arrow-up icon-arrow-down icon-share-alt icon-resize-full icon-resize-small icon-plus icon-minus icon-asterisk icon-exclamation-sign icon-gift icon-leaf icon-fire icon-eye-open icon-eye-close icon-warning-sign icon-plane icon-calendar icon-random icon-comment icon-magnet icon-chevron-up icon-chevron-down icon-retweet icon-shopping-cart icon-folder-close icon-folder-open icon-resize-vertical icon-resize-horizontal icon-bar-chart icon-twitter-sign icon-facebook-sign icon-camera-retro icon-key icon-cogs icon-comments icon-thumbs-up icon-thumbs-down icon-star-half icon-heart-empty icon-signout icon-linkedin-sign icon-pushpin icon-external-link icon-signin icon-trophy icon-github-sign icon-upload-alt icon-lemon icon-phone icon-check-empty icon-bookmark-empty icon-phone-sign icon-twitter icon-facebook icon-github icon-unlock icon-credit-card icon-rss icon-hdd icon-bullhorn icon-bell icon-certificate icon-hand-right icon-hand-left icon-hand-up icon-hand-down icon-circle-arrow-left icon-circle-arrow-right icon-circle-arrow-up icon-circle-arrow-down icon-globe icon-wrench icon-tasks icon-filter icon-briefcase icon-fullscreen icon-group icon-link icon-cloud icon-beaker icon-cut icon-copy icon-paper-clip icon-save icon-sign-blank icon-reorder icon-list-ul icon-list-ol icon-strikethrough icon-underline icon-table icon-magic icon-truck icon-pinterest icon-pinterest-sign icon-google-plus-sign icon-google-plus icon-money icon-caret-down icon-caret-up icon-caret-left icon-caret-right icon-columns icon-sort icon-sort-down icon-sort-up icon-envelope-alt icon-linkedin icon-undo icon-legal icon-dashboard icon-comment-alt icon-comments-alt icon-bolt icon-sitemap icon-umbrella icon-paste icon-lightbulb icon-exchange icon-cloud-download icon-cloud-upload icon-user-md icon-stethoscope icon-suitcase icon-bell-alt icon-coffee icon-food icon-file-alt icon-building icon-hospital icon-ambulance icon-medkit icon-fighter-jet icon-beer icon-h-sign icon-plus-sign-alt icon-double-angle-left icon-double-angle-right icon-double-angle-up icon-double-angle-down icon-angle-left icon-angle-right icon-angle-up icon-angle-down icon-desktop icon-laptop icon-tablet icon-mobile-phone icon-circle-blank icon-quote-left icon-quote-right icon-spinner icon-circle icon-reply icon-github-alt icon-folder-close-alt icon-folder-open-alt)
  end

  def new
    @link = Link.new
    render layout: false
  end

  def create
    # render json: params[:category][:category_name]
    @link = Link.create(category_params)
    redirect_to links_path
  end

  def edit
    @link = Link.find(params[:id])
    render layout: false
  end

  def update
    @link = Link.find(params[:id])
    @link.title = params[:link][:title]
    @link.url_link = params[:link][:url_link]
    @link.icon = params[:link][:icon]
    @link.display_order = params[:link][:display_order]

    @link.save
    redirect_to links_path
  end

  private
    def category_params
      params.require(:link).permit(:title, :url_link, :icon, :display_order)
    end
end
