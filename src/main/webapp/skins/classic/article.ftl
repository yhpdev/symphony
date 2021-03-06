<#include "macro-head.ftl">
<#include "macro-pagination-query.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${article.articleTitleEmojUnicode} - ${symphonyLabel}">
        <meta name="keywords" content="<#list article.articleTagObjs as articleTag>${articleTag.tagTitle}<#if articleTag?has_next>,</#if></#list>" />
        <meta name="description" content="${article.articlePreviewContent}"/>
        <#if 1 == article.articleStatus || 1 == article.articleAuthor.userStatus || 1 == article.articleType>
        <meta name="robots" content="NOINDEX,NOFOLLOW" />
        </#if>
        </@head>
        <link rel="stylesheet" href="${staticServePath}/js/lib/highlight.js-9.6.0/styles/github.css">
        <link rel="stylesheet" href="${staticServePath}/css/index.css?${staticResourceVersion}" />
        <link rel="stylesheet" href="${staticServePath}/js/lib/editor/codemirror.min.css?${staticResourceVersion}">
        <link rel="canonical" href="${servePath}${article.articlePermalink}?p=${paginationCurrentPageNum}&m=${userCommentViewMode}">
        <#if articlePrevious??>
            <link rel="prev" title="${articlePrevious.articleTitleEmojUnicode}" href="${servePath}${articlePrevious.articlePermalink}">
        </#if>
        <#if articleNext??>
            <link rel="next" title="${articleNext.articleTitleEmojUnicode}" href="${servePath}${articleNext.articlePermalink}">
        </#if>
        <!-- Open Graph -->
        <meta property="og:locale" content="zh_CN" />
        <meta property="og:type" content="article" />
        <meta property="og:title" content="${article.articleTitle} - ${symphonyLabel}" />
        <meta property="og:description" content="${article.articlePreviewContent}" />
        <meta property="og:image" content="${article.articleAuthorThumbnailURL210}" />
        <meta property="og:url" content="${servePath}${article.articlePermalink}" />
        <meta property="og:site_name" content="HacPai" />
        <!-- Twitter Card -->
        <meta name="twitter:card" content="summary" />
        <meta name="twitter:description" content="${article.articlePreviewContent}" />
        <meta name="twitter:title" content="${article.articleTitle} - ${symphonyLabel}" />
        <meta name="twitter:image" content="${article.articleAuthorThumbnailURL210}" />
        <meta name="twitter:site" content="@DL88250" />
        <meta name="twitter:creator" content="@DL88250" />
    </head>
    <body itemscope itemtype="http://schema.org/Product" class="article">
        <img itemprop="image" class="fn-none"  src="${article.articleAuthorThumbnailURL210}" />
        <p itemprop="description" class="fn-none">"${article.articlePreviewContent}"</p>
        <#include "header.ftl">
        <div class="article-body">
            <div class="wrapper">
                <div class="article-info fn-flex">
                    <#if article.articleAnonymous == 0>
                        <a rel="author" href="${servePath}/member/${article.articleAuthorName}"></#if><div
                        class="avatar-mid tooltipped tooltipped-se" aria-label="${article.articleAuthorName}" style="background-image:url('${article.articleAuthorThumbnailURL48}')"></div><#if article.articleAnonymous == 0></a></#if>
                    <div class="fn-flex-1">
                        <#if article.articleAnonymous == 0>
                            <a rel="author" href="${servePath}/member/${article.articleAuthorName}" class="ft-gray"></#if><strong class="ft-gray">${article.articleAuthorName}</strong><#if article.articleAnonymous == 0></a></#if>

                        <#if 0 == article.articleAuthor.userUAStatus>
                            <span id="articltVia" class="ft-fade" data-ua="${article.articleUA}"></span>
                        </#if>
                        <br/>
                        <#if "" != article.articleAuthorIntro>
                            <span class="ft-gray">${article.articleAuthorIntro}</span>
                        <#else>
                            <span class="ft-gray">${symphonyLabel} <#if article.articleAnonymous == 0>${article.articleAuthor.userNo?c}<#else>?</#if> ${numVIPLabel}</span>
                        </#if>
                        <br/>
                        <#list article.articleTagObjs as articleTag>
                            <a rel="tag" class="tag" href="${servePath}/tag/${articleTag.tagURI}">${articleTag.tagTitle}</a>&nbsp;
                        </#list>
                        <span class="ft-gray">
                                •&nbsp;
                                <a rel="nofollow" class="ft-gray" href="#comments">
                                    <b class="article-level<#if article.articleCommentCount lt 40>${(article.articleCommentCount/10)?int}<#else>4</#if>">${article.articleCommentCount}</b> ${cmtLabel}</a>
                                &nbsp;•&nbsp;
                                <span class="article-level<#if article.articleViewCount lt 400>${(article.articleViewCount/100)?int}<#else>4</#if>">
                                <#if article.articleViewCount < 1000>
                                ${article.articleViewCount}
                                <#else>
                                ${article.articleViewCntDisplayFormat}
                                    </#if>
                                </span>
                                ${viewLabel}
                                &nbsp;•&nbsp;
                                ${article.timeAgo}
                                <#if article.clientArticlePermalink?? && 0 < article.clientArticlePermalink?length>
                                &nbsp;•&nbsp; <a href="${article.clientArticlePermalink}" target="_blank" rel="nofollow"><span class="ft-green">${sourceLabel}</span></a>
                            </#if>
                            </span>
                    </div>

                    <div class="article-actions action-btns">
                        <#if article.isMyArticle && permissions["commonStickArticle"].permissionGrant>
                            <a class="tooltipped tooltipped-n" aria-label="${stickLabel}"
                               href="javascript:Article.stick('${article.oId}')"><span class="icon-chevron-up"></span></a> &nbsp;
                        </#if>
                        <#if article.isMyArticle && 3 != article.articleType && permissions["commonUpdateArticle"].permissionGrant>
                            <a href="${servePath}/update?id=${article.oId}" aria-label="${editLabel}"
                               class="tooltipped tooltipped-n"><span class="icon-edit"></span></a> &nbsp;
                        </#if>
                        <#if permissions["articleUpdateArticleBasic"].permissionGrant>
                            <a class="tooltipped tooltipped-n" href="${servePath}/admin/article/${article.oId}" aria-label="${adminLabel}"><span class="icon-setting"></span></a> &nbsp;
                        </#if>
                    </div>
                </div>

                <h1 class="article-title" itemprop="name">
                    <#if 1 == article.articlePerfect>
                        <span class="tooltipped tooltipped-n" aria-label="${perfectLabel}"><svg height="40" viewBox="2 2 12 12" width="23" class="ft-gray">${perfectIcon}</svg></span>
                    </#if>
                    <#if 1 == article.articleType>
                        <span class="tooltipped tooltipped-n" aria-label="${discussionLabel}"><span class="icon-locked"></span></span>
                        <#elseif 2 == article.articleType>
                            <span class="tooltipped tooltipped-n" aria-label="${cityBroadcastLabel}"><span class="icon-feed"></span></span>
                            <#elseif 3 == article.articleType>
                                <span class="tooltipped tooltipped-n" aria-label="${thoughtLabel}"><span class="icon-video"></span></span>
                    </#if>
                    ${article.articleTitleEmoj}
                </h1>

                <#if "" != article.articleAudioURL>
                    <div id="articleAudio" data-url="${article.articleAudioURL}"
                         data-author="${article.articleAuthorName}" class="aplayer"></div>
                </#if>
                <#if 3 != article.articleType>
                    <div class="content-reset article-content">
                        ${article.articleContent}
                    </div>
                    <#else>
                        <div id="thoughtProgress"><span class="bar"></span><span class="icon-video"></span><div data-text="" class="content-reset" id="thoughtProgressPreview"></div></div>
                        <div class="content-reset article-content"></div>
                </#if>

                <#if 0 < article.articleRewardPoint>
                <div id="articleRewardContent">
                    <span class="tooltipped tooltipped-w<#if article.rewarded> ft-red<#else> ft-blue</#if>"
                    <#if !article.rewarded>onclick="Article.reward(${article.oId})"</#if>
                    aria-label="${rewardLabel}"><span class="icon-points"></span> ${article.rewardedCnt}</span>

                    <div class="content-reset">
                    <#if !article.rewarded>
                         <span>
                            ${rewardTipLabel?replace("{articleId}", article.oId)?replace("{point}", article.articleRewardPoint)}
                        </span>
                        <#else>
                            ${article.articleRewardContent}
                    </#if>
                    </div>
                </div>
                </#if>
            </div>
        </div>
        <div class="main">
            <div class="wrapper">
                <#if article.articleNiceComments?size != 0>
                <div class="module nice">
                    <div class="module-header">
                        <span class="icon-thumbs-up ft-blue"></span>
                        ${niceCommentsLabel}
                    </div>
                    <div class="module-panel list comments">
                        <ul>
                        <#list article.articleNiceComments as comment>
                            <li>
                                <div class="fn-flex">
                                    <#if !comment.fromClient>
                                    <#if comment.commentAnonymous == 0>
                                    <a rel="nofollow" href="${servePath}/member/${comment.commentAuthorName}"></#if>
                                        <div class="avatar tooltipped tooltipped-se"
                                             aria-label="${comment.commentAuthorName}" style="background-image:url('${comment.commentAuthorThumbnailURL}')"></div>
                                    <#if comment.commentAnonymous == 0></a></#if>
                                    <#else>
                                    <div class="avatar tooltipped tooltipped-se"
                                         aria-label="${comment.commentAuthorName}" style="background-image:url('${comment.commentAuthorThumbnailURL}')"></div>
                                    </#if>
                                    <div class="fn-flex-1">
                                        <div class="fn-clear comment-info ft-smaller">
                                            <span class="fn-left">
                                                <#if !comment.fromClient>
                                                <#if comment.commentAnonymous == 0><a rel="nofollow" href="${servePath}/member/${comment.commentAuthorName}" class="ft-gray"></#if><span class="ft-gray">${comment.commentAuthorName}</span><#if comment.commentAnonymous == 0></a></#if>
                                                <#else><span class="ft-gray">${comment.commentAuthorName}</span>
                                                <span class="ft-fade"> • </span>
                                                <a rel="nofollow" class="ft-green" href="https://hacpai.com/article/1457158841475">API</a>
                                                </#if>
                                                <span class="ft-fade">• ${comment.timeAgo}</span>

                                                <#if comment.rewardedCnt gt 0>
                                                <#assign hasRewarded = isLoggedIn && comment.commentAuthorId != currentUser.oId && comment.rewarded>
                                                <span aria-label="<#if hasRewarded>${thankedLabel}<#else>${thankLabel} ${comment.rewardedCnt}</#if>"
                                                      class="tooltipped tooltipped-n rewarded-cnt <#if hasRewarded>ft-red<#else>ft-fade</#if>">
                                                    <span class="icon-heart"></span>${comment.rewardedCnt}
                                                </span>
                                                </#if>
                                                <#if 0 == comment.commenter.userUAStatus><span class="cmt-via ft-fade" data-ua="${comment.commentUA}"></span></#if>
                                            </span>
                                            <a class="ft-a-title fn-right tooltipped tooltipped-nw" aria-label="${goCommentLabel}"
                                               href="javascript:Comment.goComment('${servePath}/article/${article.oId}?p=${comment.paginationCurrentPageNum}&m=${userCommentViewMode}#${comment.oId}')"><span class="icon-down"></span></a>
                                        </div>
                                        <div class="content-reset comment">
                                            ${comment.commentContent}
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </#list>
                    </ul>
                    </div>
                </div>
                </#if>

                <#if pjax><!---- pjax {#comments} start ----></#if>
                <div class="module comments" id="comments">
                    <div class="comments-header module-header">
                        <span class="article-cmt-cnt">${article.articleCommentCount} ${cmtLabel}</span>
                        <span class="fn-right<#if article.articleComments?size == 0> fn-none</#if>">
                            <a class="tooltipped tooltipped-nw" href="javascript:Comment.exchangeCmtSort(${userCommentViewMode})"
                               aria-label="<#if 0 == userCommentViewMode>${changeToLabel}${realTimeLabel}${cmtViewModeLabel}<#else>${changeToLabel}${traditionLabel}${cmtViewModeLabel}</#if>"><span class="icon-<#if 0 == userCommentViewMode>sortasc<#else>time</#if>"></span></a>&nbsp;
                            <a class="tooltipped tooltipped-nw" href="javascript:Comment._bgFade($('#bottomComment'))" aria-label="${jumpToBottomCommentLabel}"><span class="icon-chevron-down"></span></a>
                        </span>
                    </div>
                    <div class="list">
                        <ul>
                            <#assign notificationCmtIds = "">
                            <#list article.articleComments as comment>
                            <#assign notificationCmtIds = notificationCmtIds + comment.oId>
                            <#if comment_has_next><#assign notificationCmtIds = notificationCmtIds + ","></#if>
                            <#include 'common/comment.ftl' />
                            </#list>
                            <#if article.articleComments?size == 0>
                                <li class="ft-center fn-pointer" onclick="$('#replyBtn').click()">
                                <img src="${noCmtImg}" class="article-no-comment-img">
                                </li>
                            </#if>
                        </ul>
                        <div id="bottomComment"></div>
                    </div>
                    <@pagination url="${servePath}${article.articlePermalink}" query="m=${userCommentViewMode}#comments" pjaxTitle="${article.articleTitle} - ${symphonyLabel}" />
                </div>
                <#if pjax><!---- pjax {#comments} end ----></#if>

                <#if sideRelevantArticles?size != 0>
                    <div class="module">
                        <div class="module-header">
                            <h2>
                                ${relativeArticleLabel}
                            </h2>
                        </div>
                        <div class="module-panel">
                            <ul class="module-list">
                                <#list sideRelevantArticles as relevantArticle>
                                    <li<#if !relevantArticle_has_next> class="last"</#if>>
                                    <#if "someone" != relevantArticle.articleAuthorName>
                                        <a rel="nofollow"
                                           href="${servePath}/member/${relevantArticle.articleAuthorName}"></#if>
                                    <span class="avatar-small slogan tooltipped tooltipped-se" aria-label="${relevantArticle.articleAuthorName}"
                                          style="background-image:url('${relevantArticle.articleAuthorThumbnailURL20}')"
                                    ></span>
                                    <#if "someone" != relevantArticle.articleAuthorName></a></#if>
                                    <a rel="nofollow" class="title" href="${servePath}${relevantArticle.articlePermalink}">${relevantArticle.articleTitleEmoj}</a>
                                    </li>
                                </#list>
                            </ul>
                        </div>
                    </div>
                </#if>

                <#if sideRandomArticles?size != 0>
                    <div class="module">
                        <div class="module-header">
                            <h2>
                                ${randomArticleLabel}
                            </h2>
                        </div>
                        <div class="module-panel">
                            <ul class="module-list">
                                <#list sideRandomArticles as randomArticle>
                                    <li<#if !randomArticle_has_next> class="last"</#if>>
                                    <#if "someone" != randomArticle.articleAuthorName>
                                        <a  rel="nofollow"
                                            href="${servePath}/member/${randomArticle.articleAuthorName}"></#if>
                                    <span class="avatar-small slogan tooltipped tooltipped-se"
                                          aria-label="${randomArticle.articleAuthorName}"
                                          style="background-image:url('${randomArticle.articleAuthorThumbnailURL20}')"></span>
                                    <#if "someone" != randomArticle.articleAuthorName></a></#if>
                                    <a class="title" rel="nofollow" href="${servePath}${randomArticle.articlePermalink}">${randomArticle.articleTitleEmoj}</a>
                                    </li>
                                </#list>
                            </ul>
                        </div>
                    </div>
                </#if>

                <#if ADLabel!="">
                    <div class="module">
                        <div class="module-header">
                            <h2>
                                ${sponsorLabel}
                                <a href="https://hacpai.com/article/1460083956075" class="fn-right ft-13 ft-gray" target="_blank">${wantPutOnLabel}</a>
                            </h2>
                        </div>
                        <div class="module-panel ad fn-clear">
                            ${ADLabel}
                        </div>
                    </div>
                </#if>
            </div>

            <div id="heatBar" class="tooltipped tooltipped-s" aria-label="${postActivityLabel}">
                <i class="heat" style="width:${article.articleHeat*3}px"></i>
            </div>
            <div id="revision"><div id="revisions"></div></div>
        </div>
        <#include "footer.ftl">
        <div class="share fn-none">
            <span id="thankArticle" aria-label="${thankLabel}"
                  class="tooltipped tooltipped-w<#if article.thanked> ft-red<#else> ft-blue</#if>"
            <#if permissions["commonThankArticle"].permissionGrant>
                <#if !article.thanked>
                    onclick="Article.thankArticle('${article.oId}', ${article.articleAnonymous})"
                </#if>
                <#else>
                    onclick="Article.permissionTip(Label.noPermissionLabel)"
            </#if>><span class="icon-heart"></span> <span class="ft-13">${article.thankedCnt}</span></span>
            <div id="qrCode" class="fn-none"
                 data-shareurl="${servePath}${article.articlePermalink}<#if isLoggedIn>?r=${currentUser.userName}</#if>"></div>
            <span class="tooltipped tooltipped-w" aria-label="share to wechat" data-type="wechat"><span class="icon-wechat"></span></span>
            <span class="tooltipped tooltipped-w" aria-label="share to weibo" data-type="weibo"><span class="icon-weibo"></span></span>
            <span class="tooltipped tooltipped-w" aria-label="share to twitter" data-type="twitter"><span class="icon-twitter"></span></span>
            <span class="tooltipped tooltipped-w" aria-label="share to google" data-type="google"><span class="icon-google"></span></span>
            <span class="tooltipped tooltipped-w" data-type="copy"
                  aria-label="${copyLabel}"
                  id="shareClipboard"><span
                    class="icon-link"></span></span>
            <input type="text" class="article-clipboard"
                   value="${servePath}${article.articlePermalink}<#if isLoggedIn>?r=${currentUser.userName}</#if>"/>
        </div>
        <div class="nav article-header">
            <h1>
                ${logoIcon}
            </h1>
            <h2 class="fn-ellipsis fn-pointer" onclick="Util.goTop()">
                ${article.articleTitleEmojUnicode}
            </h2>
            <div class="user-nav">
                <#if "" != article.articleToC>
                    <span onclick="Article.toggleToc()" aria-label="${ToCLabel}"
                          class="tooltipped tooltipped-w"><span class="icon-unordered-list ft-red"></span></span>
                </#if>

                <#if permissions["commonViewArticleHistory"].permissionGrant>
                    <span onclick="Article.revision('${article.oId}')" aria-label="${historyLabel}"
                          class="tooltipped tooltipped-w"><span class="icon-history"></span></span>
                </#if>

                <#if articlePrevious??>
                    <a rel="prev" class="tooltipped tooltipped-w" aria-label="${prevPostLabel}: ${articlePrevious.articleTitleEmojUnicode}"
                       href="${servePath}${articlePrevious.articlePermalink}">
                        <span class="icon-chevron-left"></span></a>
                </#if>

                <#if articleNext??>
                    <a rel="next" class="tooltipped tooltipped-w" aria-label="${nextPostLabel}: ${articleNext.articleTitleEmojUnicode}"
                       href="${servePath}${articleNext.articlePermalink}">
                        <span class="icon-chevron-right"></span>
                    </a>
                </#if>

                <span class="tooltipped tooltipped-w<#if isLoggedIn && 0 == article.articleVote> ft-red</#if>" aria-label="${upLabel}"
                <#if permissions["commonGoodArticle"].permissionGrant>
                    onclick="Article.voteUp('${article.oId}', 'article', this)"
                    <#else>
                        onclick="Article.permissionTip(Label.noPermissionLabel)"
                </#if>><span class="icon-thumbs-up"></span> ${article.articleGoodCnt}</span>

                <span  class="tooltipped tooltipped-w<#if isLoggedIn && 1 == article.articleVote> ft-red</#if>" aria-label="${downLabel}"
                <#if permissions["commonBadArticle"].permissionGrant>
                    onclick="Article.voteDown('${article.oId}', 'article', this)"
                <#else>
                    onclick="Article.permissionTip(Label.noPermissionLabel)"
                </#if>><span class="icon-thumbs-down"></span> ${article.articleBadCnt}</span>

                <#if isLoggedIn && isFollowing>
                    <span class="tooltipped tooltipped-w ft-red" aria-label="${uncollectLabel}"
                    <#if permissions["commonFollowArticle"].permissionGrant>
                        onclick="Util.unfollow(this, '${article.oId}', 'article', ${article.articleCollectCnt})"
                        <#else>
                            onclick="Article.permissionTip(Label.noPermissionLabel)"
                    </#if>><span class="icon-star"></span> ${article.articleCollectCnt}</span>
                    <#else>
                        <span class="tooltipped tooltipped-w" aria-label="${collectLabel}"
                        <#if permissions["commonFollowArticle"].permissionGrant>
                            onclick="Util.follow(this, '${article.oId}', 'article', ${article.articleCollectCnt})"
                            <#else>
                                onclick="Article.permissionTip(Label.noPermissionLabel)"
                        </#if>><span class="icon-star"></span> ${article.articleCollectCnt}</span>
                </#if>

                <#if isLoggedIn && isWatching>
                    <span class="tooltipped tooltipped-w ft-red" aria-label="${unfollowLabel}"
                    <#if permissions["commonWatchArticle"].permissionGrant>
                        onclick="Util.unfollow(this, '${article.oId}', 'article-watch', ${article.articleWatchCnt})"
                        <#else>
                            onclick="Article.permissionTip(Label.noPermissionLabel)"
                    </#if>><span class="icon-view"></span> ${article.articleWatchCnt}</span>
                    <#else>
                        <span class="tooltipped tooltipped-w" aria-label="${followLabel}"
                        <#if permissions["commonWatchArticle"].permissionGrant>
                            onclick="Util.follow(this, '${article.oId}', 'article-watch', ${article.articleWatchCnt})"
                            <#else>
                                onclick="Article.permissionTip(Label.noPermissionLabel)"
                        </#if>><span class="icon-view"></span> ${article.articleWatchCnt}</span>
                </#if>
            </div>
        </div>

        <#if "" != article.articleToC && 3 != article.articleType>
            <div class="module" id="articleToC">
                <div class="module-panel">
                    ${article.articleToC}
                </div>
            </div>
        </#if>
        <span class="tooltipped tooltipped-w radio-btn" id="replyBtn"
              data-hasPermission="${permissions['commonAddComment'].permissionGrant?c}"
              aria-label="${cmtLabel}"><span class="icon-reply"></span></span>

        <div class="editor-panel">
            <div class="editor-bg"></div>
            <div class="wrapper">
                <#if isLoggedIn && discussionViewable && article.articleCommentable>
                    <div class="form fn-clear comment-wrap">
                        <div class="fn-clear">
                            <div id="replyUseName" class="fn-left"></div>
                            <span class="tooltipped tooltipped-w fn-right fn-pointer editor-hide" aria-label="${hideLabel}"><span class="icon-chevron-down"></span></span>
                        </div>
                        <div class="article-comment-content">
                            <textarea id="commentContent" placeholder="${commentEditorPlaceholderLabel}"></textarea>
                            <div class="fn-clear comment-submit">
                                <div class="tip fn-left" id="addCommentTip"></div>
                                <div class="fn-right">
                                    <#if permissions["commonAddCommentAnonymous"].permissionGrant>
                                        <label class="cmt-anonymous">${anonymousLabel}<input type="checkbox" id="commentAnonymous"></label>
                                    </#if>
                                    <button class="red mid" onclick="Comment.add('${article.oId}', '${csrfToken}')">${submitLabel}</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </#if>
            </div>
        </div>
        <script src="${staticServePath}/js/lib/compress/article-libs.min.js?${staticResourceVersion}"></script>
        <script src="${staticServePath}/js/channel${miniPostfix}.js?${staticResourceVersion}"></script>
        <script src="${staticServePath}/js/article${miniPostfix}.js?${staticResourceVersion}"></script>
        <script>
            Label.commentErrorLabel = "${commentErrorLabel}";
            Label.symphonyLabel = "${symphonyLabel}";
            Label.rewardConfirmLabel = "${rewardConfirmLabel?replace('{point}', article.articleRewardPoint)}";
            Label.thankArticleConfirmLabel = "${thankArticleConfirmLabel?replace('{point}', pointThankArticle)}";
            Label.thankSentLabel = "${thankSentLabel}";
            Label.articleOId = "${article.oId}";
            Label.articleTitle = "${article.articleTitle}";
            Label.recordDeniedLabel = "${recordDeniedLabel}";
            Label.recordDeviceNotFoundLabel = "${recordDeviceNotFoundLabel}";
            Label.csrfToken = "${csrfToken}";
            Label.upLabel = "${upLabel}";
            Label.downLabel = "${downLabel}";
            Label.uploadLabel = "${uploadLabel}";
            Label.userCommentViewMode = ${userCommentViewMode};
            Label.stickConfirmLabel = "${stickConfirmLabel}";
            Label.audioRecordingLabel = '${audioRecordingLabel}';
            Label.uploadingLabel = '${uploadingLabel}';
            Label.copiedLabel = '${copiedLabel}';
            Label.copyLabel = '${copyLabel}';
            Label.noRevisionLabel = "${noRevisionLabel}";
            Label.thankedLabel = "${thankedLabel}";
            Label.thankLabel = "${thankLabel}";
            Label.isAdminLoggedIn = ${isAdminLoggedIn?c};
            Label.adminLabel = '${adminLabel}';
            Label.thankSelfLabel = '${thankSelfLabel}';
            Label.replyLabel = '${replyLabel}';
            Label.articleAuthorName = '${article.articleAuthorName}';
            Label.referenceLabel = '${referenceLabel}';
            Label.goCommentLabel = '${goCommentLabel}';
            Label.commonAtUser = '${permissions["commonAtUser"].permissionGrant?c}';
            Label.qiniuDomain = '${qiniuDomain}';
            Label.qiniuUploadToken = '${qiniuUploadToken}';
            Label.noPermissionLabel = '${noPermissionLabel}';
            Label.imgMaxSize = ${imgMaxSize?c};
            Label.fileMaxSize = ${fileMaxSize?c};
            Label.articleChannel = "${wsScheme}://${serverHost}:${serverPort}${contextPath}/article-channel?articleId=${article.oId}&articleType=${article.articleType}";
            <#if isLoggedIn>
                Label.currentUserName = '${currentUser.userName}';
                Label.notificationCmtIds = '${notificationCmtIds}';
            </#if>
            <#if 3 == article.articleType>
                Article.playThought('${article.articleContent}');
            </#if>
        </script>
    </body>
</html>
