# Access

![Platform](https://img.shields.io/cocoapods/p/JOEmojiableBtn.svg?style=flat)

## Installation
need pod install will execute project  
```swift
pod install
 
```
## Demo

![image](https://github.com/Yu-Yen-Chou/File/blob/master/Access_Img/access.gif)


## Usage
Language: Swift  
Architecture: MVVM  
Library: [Alamofire](https://github.com/Alamofire/Alamofire) ,[Kingfisher](https://github.com/onevcat/Kingfisher)    

 GitHub API Documentation:  
>• Get all users - ​https://developer.github.com/v3/users/#get-all-users  
• Get a single user -   ​https://developer.github.com/v3/#link-header​  

### • Get all users
Lists all users, in the order that they signed up on GitHub. This list includes personal user accounts and organization accounts.  

> • Load when scrolled to bottom  
• Start with since=0, page size = 20  
• Limit to 100 users  
• API - ​https://api.github.com/users?since=0&per_page=20​    

### Response
```swift
[
  {
    "login": "mojombo",
    "id": 1,
    "node_id": "MDQ6VXNlcjE=",
    "avatar_url": "https://avatars0.githubusercontent.com/u/1?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/mojombo",
    "html_url": "https://github.com/mojombo",
    "followers_url": "https://api.github.com/users/mojombo/followers",
    "following_url": "https://api.github.com/users/mojombo/following{/other_user}",
    "gists_url": "https://api.github.com/users/mojombo/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/mojombo/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/mojombo/subscriptions",
    "organizations_url": "https://api.github.com/users/mojombo/orgs",
    "repos_url": "https://api.github.com/users/mojombo/repos",
    "events_url": "https://api.github.com/users/mojombo/events{/privacy}",
    "received_events_url": "https://api.github.com/users/mojombo/received_events",
    "type": "User",
    "site_admin": false
  },
  {
    "login": "defunkt",
    "id": 2,
    "node_id": "MDQ6VXNlcjI=",
    "avatar_url": "https://avatars0.githubusercontent.com/u/2?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/defunkt",
    "html_url": "https://github.com/defunkt",
    "followers_url": "https://api.github.com/users/defunkt/followers",
    "following_url": "https://api.github.com/users/defunkt/following{/other_user}",
    "gists_url": "https://api.github.com/users/defunkt/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/defunkt/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/defunkt/subscriptions",
    "organizations_url": "https://api.github.com/users/defunkt/orgs",
    "repos_url": "https://api.github.com/users/defunkt/repos",
    "events_url": "https://api.github.com/users/defunkt/events{/privacy}",
    "received_events_url": "https://api.github.com/users/defunkt/received_events",
    "type": "User",
    "site_admin": false
  }
]
 
```
### • Get a single user  
Provides publicly available information about someone with a GitHub account.  
>• API - https://api.github.com/users/login  

>>• avatar_url  
• name  
• bio  
• login  
• site_admin   
• location  
• blog  
### Response
```swift
{
  "login": "bmizerany",
  "id": 46,
  "node_id": "MDQ6VXNlcjQ2",
  "avatar_url": "https://avatars2.githubusercontent.com/u/46?v=4",
  "gravatar_id": "",
  "url": "https://api.github.com/users/bmizerany",
  "html_url": "https://github.com/bmizerany",
  "followers_url": "https://api.github.com/users/bmizerany/followers",
  "following_url": "https://api.github.com/users/bmizerany/following{/other_user}",
  "gists_url": "https://api.github.com/users/bmizerany/gists{/gist_id}",
  "starred_url": "https://api.github.com/users/bmizerany/starred{/owner}{/repo}",
  "subscriptions_url": "https://api.github.com/users/bmizerany/subscriptions",
  "organizations_url": "https://api.github.com/users/bmizerany/orgs",
  "repos_url": "https://api.github.com/users/bmizerany/repos",
  "events_url": "https://api.github.com/users/bmizerany/events{/privacy}",
  "received_events_url": "https://api.github.com/users/bmizerany/received_events",
  "type": "User",
  "site_admin": false,
  "name": "Blake Mizerany",
  "company": null,
  "blog": "",
  "location": null,
  "email": null,
  "hireable": null,
  "bio": null,
  "public_repos": 156,
  "public_gists": 165,
  "followers": 1252,
  "following": 19,
  "created_at": "2008-01-24T04:44:30Z",
  "updated_at": "2020-02-14T15:31:29Z"
}
 
```


## Example Code
>#### Circle image

```swift
  Poster_img.layer.masksToBounds = true
  Poster_img.layer.cornerRadius = Poster_img.frame.width/2
 
```
>#### Read cache image
```swift
   let articleUrl = URL(string: base_url)
   let imageResource = ImageResource(downloadURL: articleUrl!, cacheKey: base_url)
   Poster_img.kf.setImage(with: imageResource)
 
```
>#### Animation cell 
```swift
func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
{
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
    UIView.animate(withDuration: 0.25, animations: {
    cell.layer.transform=CATransform3DMakeScale(1, 1, 1)
   })
}
 
```
>#### Load when scrolled to bottom   
```swift
func scrollViewDidScroll(_ scrollView: UIScrollView)
{
   let offsetY = scrollView.contentOffset.y
   let contentHeight = scrollView.contentSize.height
   if (offsetY > contentHeight - scrollView.frame.height ) && !isLoading
   {
      loadMoreData()
   }
}
 
```

