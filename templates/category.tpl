<input type="hidden" template-variable="category_id" value="{cid}" />
<input type="hidden" template-variable="category_name" value="{name}" />
<input type="hidden" template-variable="topic_count" value="{topic_count}" />
<input type="hidden" template-variable="currentPage" value="{currentPage}" />
<input type="hidden" template-variable="pageCount" value="{pageCount}" />

<ol class="breadcrumb">
	<!-- BEGIN breadcrumbs -->
	<li itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
		<!-- IF !@last --><a href="{breadcrumbs.url}" itemprop="url"><!-- ENDIF !@last -->
		<span itemprop="title">
			{breadcrumbs.text}
			<!-- IF @last -->
			<!-- IF !feeds:disableRSS --><a target="_blank" href="{relative_path}/category/{cid}.rss"><i class="fa fa-rss-square"></i></a><!-- ENDIF !feeds:disableRSS -->
			<!-- ENDIF @last -->
		</span>
		<!-- IF !@last --></a><!-- ENDIF !@last -->
	</li>
	<!-- END breadcrumbs -->
</ol>

<div class="subcategories row">
	<!-- BEGIN children -->
	<!-- IMPORT partials/category_child.tpl -->
	<!-- END children -->
</div>

<div class="category row">
	<div class="col-lg-12 col-sm-12">
		<div class="col-sm-6 col-lg-6 col-xs-6 title_forum"><h1>{name}</h1><p>{description}</p></div>
		<!-- IF privileges.topics:create -->
		<div class="col-sm-6 col-lg-6 col-xs-6 no-p">
			<button id="new_post" class="btn btn-primary new_post_btn">[[category:new_topic_button]]<span>+</span></button>
		</div>
		<!-- ENDIF privileges.topics:create -->
	</div>
	<div class="{topic_row_size}" no-widget-class="col-lg-12 col-sm-12" no-widget-target="sidebar">
		<div class="header category-tools clearfix">
			<div class="category-tools-button">
				<span class="pull-right">
					<!-- IF loggedIn -->
					<button type="button" class="btn btn-default btn-success watch <!-- IF !isIgnored -->hidden<!-- ENDIF !isIgnored --> tool"><i class="fa fa-eye"></i> [[topic:watch]]</button>
					<button type="button" class="btn btn-default btn-warning ignore <!-- IF isIgnored -->hidden<!-- ENDIF isIgnored --> tool"><i class="fa fa-eye-slash"></i> [[category:ignore]]</button>
					<!-- ENDIF loggedIn -->

					<!-- IMPORT partials/category_tools.tpl -->

					<div class="dropdown share-dropdown inline-block">
						<button type="button" class="btn btn-default dropdown-toggle tool" data-toggle="dropdown">
							[[topic:share]] <span class="caret"></span>
						</button>

						<!-- IMPORT partials/share_dropdown.tpl -->
					</div>
				</span>
			</div>
		</div>

		<!-- IF !topics.length -->
		<div class="alert alert-warning" id="category-no-topics">
			[[category:no_topics]]
		</div>
		<!-- ENDIF !topics.length -->

		<ul id="topics-container" itemscope itemtype="http://www.schema.org/ItemList" data-nextstart="{nextStart}">
			<div class="list-post-header"></div>
			<meta itemprop="itemListOrder" content="descending">
			<!-- BEGIN topics -->
			<li class="category-item<!-- IF topics.locked --> locked<!-- ENDIF topics.locked --><!-- IF topics.pinned --> pinned<!-- ENDIF topics.pinned --><!-- IF topics.deleted --> deleted<!-- ENDIF topics.deleted --><!-- IF topics.unread --> unread<!-- ENDIF topics.unread -->" itemprop="itemListElement" data-tid="{topics.tid}" data-index="{topics.index}">

				<div class="col-md-12 col-xs-12 panel panel-default topic-row">
					<!-- IF privileges.editable -->
					<i class="fa fa-fw fa-square-o pull-left select pointer"></i>
					<!-- ENDIF privileges.editable -->
					<a href="{relative_path}/user/{topics.user.userslug}" class="pull-left">
						<img src="<!-- IF topics.thumb -->{topics.thumb}<!-- ELSE -->{topics.user.picture}<!-- ENDIF topics.thumb -->" class="img-rounded user-img" title="{topics.user.username}"/>
					</a>

					<h3>
						<a href="{relative_path}/topic/{topics.slug}" itemprop="url">
							<meta itemprop="name" content="{topics.title}">

							<strong><i class="fa fa-thumb-tack<!-- IF !topics.pinned --> hide<!-- ENDIF !topics.pinned -->"></i> <i class="fa fa-lock<!-- IF !topics.locked --> hide<!-- ENDIF !topics.locked -->"></i></strong>
							<span class="topic-title">{topics.title}</span>
						</a>
					</h3>

					<small>
						<span class="topic-stats">
							[[global:posts]]
							<strong class="human-readable-number" title="{topics.postcount}">{topics.postcount}</strong>
						</span>
						|
						<span class="topic-stats">
							[[global:views]]
							<strong class="human-readable-number" title="{topics.viewcount}">{topics.viewcount}</strong>
						</span>
						|
						<span>
							[[global:posted_ago, <span class="timeago" title="{topics.relativeTime}"></span>]]
						</span>

						<span class="pull-right">
							<!-- IF topics.unreplied -->
							[[category:no_replies]]
							<!-- ELSE -->
							<a href="<!-- IF topics.teaser.user.userslug -->{relative_path}/user/{topics.teaser.user.userslug}<!-- ELSE -->#<!-- ENDIF topics.teaser.user.userslug -->">
								<img class="teaser-pic" src="{topics.teaser.user.picture}" title="{topics.teaser.user.username}"/>
							</a>
							<a href="{relative_path}/topic/{topics.slug}/{topics.teaser.index}">
								[[global:replied_ago, <span class="timeago" title="{topics.teaser.timestamp}"></span>]]
							</a>
							<!-- ENDIF topics.unreplied -->
						</span>

						<!-- IMPORT partials/category_tags.tpl -->
					</small>
				</div>
			</li>
			<!-- END topics -->
		</ul>
		<!-- IF config.usePagination -->
		<div class="text-center">
			<ul class="pagination">
				<li class="previous pull-left"><a href="#"><i class="fa fa-chevron-left"></i> [[global:previouspage]]</a></li>
				<li class="next pull-right"><a href="#">[[global:nextpage]] <i class="fa fa-chevron-right"></i></a></li>
			</ul>
		</div>
		<!-- ENDIF config.usePagination -->
	</div>

	<!-- IF topics.length -->
	<div widget-area="sidebar" class="col-md-3 col-xs-12 category-sidebar"></div>
	<!-- ENDIF topics.length -->
</div>

<!-- IMPORT partials/move_thread_modal.tpl -->
<!-- IMPORT partials/noscript/paginator.tpl -->