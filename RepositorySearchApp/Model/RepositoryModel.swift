//
//  RepositoryModel.swift
//  RepositorySearchApp
//
//  Created by 陳韋綸 on 2023/10/20.
//

import Foundation

struct RepositoryResponse: Decodable {
    var total_count: Int?
    var incomplete_results: Bool?
    var items: [RepositoryModel]?
  }

struct RepositoryModel: Decodable {
    var id: Int?
    var node_id: String?
    var name: String?
    var full_name: String?
    var owner: RepositoryOwner?
    var `private`: Bool?
    var html_url: String?
    var description: String?
    var fork: Bool?
    var url: URL?
    var created_at: String?
    var updated_at: String?
    var pushed_at: String?
    var homepage: String?
    var size: Int?
    var stargazers_count: Int?
    var watchers_count: Int?
    var language: String?
    var forks_count: Int?
    var open_issues_count: Int?
    var master_branch: String?
    var default_branch: String?
    var score: Int?
    var archive_url: String?
    var assignees_url: String?
    var blobs_url: String?
    var branches_url: String?
    var collaborators_url: String?
    var comments_url: String?
    var commits_url: String?
    var compare_url: String?
    var contents_url: String?
    var contributors_url: String?
    var deployments_url: String?
    var downloads_url: String?
    var events_url: String?
    var forks_url: String?
    var git_commits_url: String?
    var git_refs_url: String?
    var git_tags_url: String?
    var git_url: String?
    var issue_comment_url: String?
    var issue_events_url: String?
    var issues_url: String?
    var keys_url: String?
    var labels_url: String?
    var languages_url: String?
    var merges_url: String?
    var milestones_url: String?
    var notifications_url: String?
    var pulls_url: String?
    var releases_url: String?
    var ssh_url: String?
    var stargazers_url: String?
    var statuses_url: String?
    var subscribers_url: String?
    var subscription_url: String?
    var tags_url: String?
    var teams_url: String?
    var trees_url: String?
    var clone_url: String?
    var mirror_url: String?
    var hooks_url: String?
    var svn_url: String?
    var forks: Int?
    var open_issues: Int?
    var watchers: Int?
    var has_issues: Bool?
    var has_projects: Bool?
    var has_pages: Bool?
    var has_wiki: Bool?
    var has_downloads: Bool?
    var archived: Bool?
    var disabled: Bool?
    var visibility: String?
    var license: RepositoryLicense?
  }

struct RepositoryOwner: Decodable {
    var login: String?
    var id: Int?
    var node_id: String?
    var avatar_url: URL?
    var gravatar_id: String?
    var url: URL?
    var received_events_url: String?
    var type: String?
    var html_url: String?
    var followers_url: String?
    var following_url: String?
    var gists_url: String?
    var starred_url: String?
    var subscriptions_url: String?
    var organizations_url: String?
    var repos_url: String?
    var events_url: String?
    var site_admin: Bool?
  }

struct RepositoryLicense: Decodable {
    var key: String?
    var name: String?
    var url: String?
    var spdx_id: String?
    var node_id: String?
    var html_url: String?
  }
