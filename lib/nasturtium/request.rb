require_relative "faraday" # !! Potential ruby 3.0 difference in module loading? relative differs from Serrano
require "faraday/follow_redirects"
require_relative "utils"

module Nasturtium

  class Request
    attr_accessor :endpoint
    attr_accessor :q
    attr_accessor :verbose

    attr_accessor :options

    def initialize(**args)
      @endpoint = args[:endpoint]
      @method = args[:method]
      @verbose = args[:verbose]
      @color = args[:color]
      @style = args[:style]
      @tile_size = args[:tile_size]
      @q = args[:q]
      @admin_level = args[:admin_level]
      @name = args[:name]
      @search_on = args[:search_on]
      @sources = args[:sources]
      @place_id = args[:place_id]
      @preferred_place_id = args[:preferred_place_id]
      @locale = args[:locale]
      @is_active = args[:is_active]
      @taxon_id = args[:taxon_id]
      @observation_taxon_id = args[:observation_taxon_id]
      @parent_id = args[:parent_id]
      @rank = args[:rank]
      @rank_level = args[:rank_level]
      @observation_rank = args[:observation_rank]
      @category = args[:category]
      @id = args[:id]
      @not_id = args[:not_id]
      @id_above = args[:id_above]
      @id_below = args[:id_below]
      @only_id = args[:only_id]
      @all_names = args[:all_names]
      @acc = args[:acc]
      @current = args[:current]
      @current_taxon = args[:current_taxon]
      @own_observation = args[:own_observation]
      @is_change = args[:is_change]
      @captive = args[:captive]
      @endemic = args[:endemic]
      @geo = args[:geo]
      @identified = args[:identified]
      @introduced = args[:introduced]
      @mappable = args[:mappable]
      @native = args[:native]
      @out_of_range = args[:out_of_range]
      @pcid = args[:pcid]
      @photos = args[:photos]
      @popular = args[:popular]
      @sounds = args[:sounds]
      @taxon_active = args[:taxon_active]
      @observation_taxon_active = args[:observation_taxon_active]
      @taxon_is_active = args[:taxon_is_active]
      @threatened = args[:threatened]
      @verifiable = args[:verifiable]
      @licensed = args[:licensed]
      @photo_licensed = args[:photo_licensed]
      @photo_license = args[:photo_license]
      @sound_license = args[:sound_license]
      @ofv_datatype = args[:ofv_datatype]
      @project_id = args[:project_id]
      @project_type = args[:project_type]
      @site_id = args[:site_id]
      @without_taxon_id = args[:without_taxon_id]
      @without_observation_taxon_id = args[:without_observation_taxon_id]
      @taxon_name = args[:taxon_name]
      @user = args[:user]
      @password = args[:password]
      @body = args[:body]
      @authenticity_token = args[:authenticity_token]
      @user_id = args[:user_id]
      @user_login = args[:user_login]
      @login = args[:login]
      @ident_user_id = args[:ident_user_id]
      @day = args[:day]
      @month = args[:month]
      @year = args[:year]
      @term_id = args[:term_id]
      @without_term_id = args[:without_term_id]
      @term_value_id = args[:term_value_id]
      @without_term_value_id = args[:without_term_value_id]
      @acc_below = args[:acc_below]
      @acc_below_or_unknown = args[:acc_below_or_unknown]
      @acc_above = args[:acc_above]
      @before = args[:before]
      @after= args[:after]
      @observed_before = args[:observed_before]
      @observed_on = args[:observed_on]
      @observed_after = args[:observed_after]
      @created_before = args[:created_before]
      @created_on = args[:created_on]
      @created_after = args[:created_after]
      @observation_created_after = args[:observation_created_after]
      @observation_created_before = args[:observation_created_before]
      @unobserved_by_user_id = args[:unobserved_by_user_id]
      @apply_project_rules_for = args[:apply_project_rules_for]
      @conservation_status = args[:conservation_status]
      @conservation_status_authority = args[:conservation_status_authority]
      @conservation_status_iucn = args[:conservation_status_iucn]
      @geoprivacy = args[:geoprivacy]
      @taxon_geoprivacy = args[:taxon_geoprivacy]
      @rank_lowest = args[:rank_lowest]
      @rank_highest = args[:rank_highest]
      @observation_rank_lowest = args[:observation_rank_lowest]
      @observation_rank_highest = args[:observation_rank_highest]
      @iconic_taxa = args[:iconic_taxa]
      @iconic_taxon_id = args[:iconic_taxon_id]
      @observation_iconic_taxon_id = args[:observation_iconic_taxon_id]
      @identifications = args[:identifications]
      @latitude = args[:latitude]
      @longitude = args[:longitude]
      @radius = args[:radius]
      @ne_latitude = args[:ne_latitude]
      @ne_longitude = args[:ne_longitude]
      @sw_latitude = args[:sw_latitude]
      @sw_longitude = args[:sw_longitude]
      @list_id = args[:list_id]
      @not_in_project = args[:not_in_project]
      @not_matching_project_rules_for = args[:not_matching_project_rules_for]
      @quality_grade = args[:quality_grade]
      @updated_since = args[:updated_since]
      @viewer_id = args[:viewer_id]
      @reviewed = args[:reviewed]
      @featured = args[:featured]
      @noteworthy = args[:noteworthy]
      @rule_details = args[:rule_details]
      @type = args[:type]
      @member_id = args[:member_id]
      @has_params = args[:has_params]
      @has_posts = args[:has_posts]
      @ttl = args[:ttl]
      @page = args[:page]
      @per_page = args[:per_page]
      @order = args[:order]
      @order_by = args[:order_by]
      @options = args[:options] # TODO: not added at nasturtium.rb
      @headers = args[:headers]
      @override_base_url = args[:base_url]
    end

    # TODO: arrays are done like this source[]=users,projects but sometime without the brackets?
    def perform

      args = {
        color: @color,
        style: @style,
        tile_size: @tile_size,
        q: @q,
        admin_level: @admin_level,
        name: @name,
        search_on: @search_on,
        sources: @sources,
        place_id: @place_id,
        preferred_place_id: @preferred_place_id,
        is_active: @is_active,
        taxon_id: @taxon_id,
        observation_taxon_id: @observation_taxon_id,
        parent_id: @parent_id,
        rank: @rank,
        observation_rank: @observation_rank,
        category: @category,
        rank_level: @rank_level,
        id: @id,
        id_above: @id_above,
        id_below: @id_below,
        only_id: @only_id,
        all_names: @all_names,
        not_id: @not_id,
        acc: @acc,
        current: @current,
        current_taxon: @current_taxon,
        own_observation: @own_observation,
        is_change: @is_change,
        captive: @captive,
        endemic: @endemic,
        geo: @geo,
        identified: @identified,
        introduced: @introduced,
        mappable: @mappable,
        native: @native,
        out_of_range: @out_of_range,
        pcid: @pcid,
        photos: @photos,
        popular: @popular,
        sounds: @sounds,
        taxon_active: @taxon_active,
        observation_taxon_active: @observation_taxon_active,
        taxon_is_active: @taxon_is_active,
        threatened: @threatened,
        verifiable: @verifiable,
        licensed: @licensed,
        photo_licensed: @photo_licensed,
        photo_license: @photo_license,
        sound_license: @sound_license,
        ofv_datatype: @ofv_datatype,
        project_id: @project_id,
        project_type: @project_type,
        site_id: @site_id,
        without_taxon_id: @without_taxon_id,
        without_observation_taxon_id: @without_observation_taxon_id,
        taxon_name: @taxon_name,
        'user[email]': @user,
        'user[password]': @password,
        authenticity_token: @authenticity_token,
        user_id: @user_id,
        user_login: @user_login,
        login: @login,
        ident_user_id: @ident_user_id,
        day: @day,
        month: @month,
        year: @year,
        term_id: @term_id,
        without_term_id: @without_term_id,
        term_value_id: @term_value_id,
        without_term_value_id: @without_term_value_id,
        acc_below: @acc_below,
        acc_below_or_unknown: @acc_below_or_unknown,
        acc_above: @acc_above,
        d1: @after,
        d2: @before,
        observed_d1: @observed_after,
        observed_on: @observed_on,
        observed_d2: @observed_before,
        created_on: @created_on,
        created_d1: @created_after,
        created_d2: @created_before,
        observation_created_d1: @observation_created_after,
        observation_created_d2: @observation_created_before,
        unobserved_by_user_id: @unobserved_by_user_id,
        apply_project_rules_for: @apply_project_rules_for,
        cs: @conservation_status,
        csa: @conservation_status_authority,
        csi: @conservation_status_iucn,
        geoprivacy: @geoprivacy,
        taxon_geoprivacy: @taxon_geoprivacy,
        lrank: @rank_lowest,
        hrank: @rank_highest,
        observation_lrank: @observation_rank_lowest,
        observation_hrank: @observation_rank_highest,
        iconic_taxa: @iconic_taxa,
        iconic_taxon_id: @iconic_taxon_id,
        observation_iconic_taxon_id: @observation_iconic_taxon_id,
        identifications: @identifications,
        lat: @latitude,
        lng: @longitude,
        radius: @radius,
        nelat: @ne_latitude,
        nelng: @ne_longitude,
        swlat: @sw_latitude,
        swlng: @sw_longitude,
        list_id: @list_id,
        not_in_project: @not_in_project,
        not_matching_project_rules_for: @not_matching_project_rules_for,
        quality_grade: @quality_grade,
        updated_since: @updated_since,
        viewer_id: @viewer_id,
        reviewed: @reviewed,
        featured: @featured,
        noteworthy: @noteworthy,
        rule_details: @rule_details,
        type: @type,
        member_id: @member_id,
        has_params: @has_params,
        has_posts: @has_posts,
        ttl: @ttl,
        locale: @locale,
        page: @page,
        per_page: @per_page,
        order: @order,
        order_by: @order_by,
      }
      opts = args.delete_if { |_k, v| v.nil? }

      Faraday::Utils.default_space_encoding = "+"

      if @override_base_url.nil?
        @base_url = Nasturtium.base_url
      else
        @base_url = @override_base_url
      end

      conn = if verbose
               Faraday.new(url: @base_url) do |f|
                 f.response :logger
                 f.use Faraday::NasturtiumErrors::Middleware
                 f.adapter Faraday.default_adapter
               end
             else
               Faraday.new(url: @base_url) do |f|
                 f.use Faraday::NasturtiumErrors::Middleware
                 f.adapter Faraday.default_adapter
               end
             end

      conn.headers['Accept'] = 'application/json,*/*'
      conn.headers[:user_agent] = make_user_agent
      conn.headers["X-USER-AGENT"] = make_user_agent

      if @method == "POST"
        puts '11111111111111111111111111111111111'
        conn.headers['Accept'] = 'application/json,text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8'
        conn.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        res = conn.post(endpoint, @body)
      else
        res = conn.get(endpoint, opts)
      end

      if @headers
        res.headers
      else
        # Handles endpoints that do not return JSON
        begin
          MultiJson.load(res.body)
        rescue MultiJson::ParseError
          res.body
        end
      end
    end
  end
end
