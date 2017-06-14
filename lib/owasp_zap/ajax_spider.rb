module OwaspZap
    class AjaxSpider

        RUNNING = "running".freeze

        def initialize(params = {})
            @base = params[:base]
            @target = params[:target]
            @api_key = params[:api_key]
        end

        def start
            set_query "#{@base}/JSON/ajaxSpider/action/scan/"
        end

        def spider_as_user(context_id, user_id, params={})
            params = {contextName: context_id, userName: user_id}.merge(params)
            set_query "#{@base}/JSON/ajaxSpider/action/scanAsUser/", params
        end

        def set_max_crawl_depth(crawl_depth)
            params = {Integer: crawl_depth}
            set_query "#{@base}/JSON/ajaxSpider/action/setOptionMaxCrawlDepth/", params
        end

        def set_browser(browser_id)
            params = {String: browser_id}
            set_query "#{@base}/JSON/ajaxSpider/action/setOptionBrowserId/", params
        end

        def stop
            RestClient::get "#{@base}/JSON/ajaxSpider/action/stop/?zapapiformat=JSON&apikey=#{@api_key}"
        end

        def status
            ret = JSON.parse(RestClient::get("#{@base}/JSON/ajaxSpider/view/status/?zapapiformat=JSON&apikey=#{@api_key}"))
            if ret.has_key? "status"
                ret["status"]
            else
                "stopped"
            end
        end

        def running?
            self.status == RUNNING
        end

        private

        def set_query(addr, params={})
            default_params = {:zapapiformat=>"JSON",:url=>@target, :apikey=>@api_key}
            url = Addressable::URI.parse addr
            url.query_values = default_params.merge params
            RestClient::get url.normalize.to_str
        end

    end
end
