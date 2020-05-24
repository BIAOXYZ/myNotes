
# OAuth official

Wiki's:
- OAuth https://en.wikipedia.org/wiki/OAuth
- 开放授权 https://zh.wikipedia.org/wiki/%E5%BC%80%E6%94%BE%E6%8E%88%E6%9D%83

RFC's:
- The OAuth 2.0 Authorization Framework https://tools.ietf.org/html/rfc6749
- The OAuth 2.0 Authorization Framework: Bearer Token Usage https://tools.ietf.org/html/rfc6750

OAuth https://oauth.net/
- OAuth 2.0 https://oauth.net/2/
- OAuth Code https://oauth.net/code/
  * OAuth Libraries for Python https://oauth.net/code/python/
    + Rauth: A Python library for OAuth 1.0/a, 2.0, and Ofly. https://github.com/litl/rauth
      > Rauth https://rauth.readthedocs.io/en/latest/
- OAuth 2.0 Device Grant https://oauth.net/2/device-flow/
  * OAuth 2.0 Device Authorization Grant draft-ietf-oauth-device-flow-15 https://tools.ietf.org/html/draft-ietf-oauth-device-flow-15
- OAuth Article https://oauth.net/articles/
  * OAuth 2 Simplified https://aaronparecki.com/oauth-2-simplified/
  * OAuth articles by Alex Bilbie https://alexbilbie.com/tag/oauth/
    + A Guide To OAuth 2.0 Grants https://alexbilbie.com/guide-to-oauth-2-grants/

# OAuth related project

ORY Hydra -- OAuth2 Server and OpenID Certified™ OpenID Connect Provider written in Go - cloud native, security-first, open source API security for your infrastructure. SDKs for any language. https://github.com/ory/hydra || https://www.ory.sh/hydra/

# OAuth others

## OAuth 2.0 Playground

OAuth 2.0 Playground https://www.oauth.com/playground/
> OAuth 2.0 Servers https://www.oauth.com/

## OAuth一般性攻略

OAuth 2.0 Tutorial https://www.tutorialspoint.com/oauth2.0/

***阮一峰OAuth***：
- 理解OAuth 2.0 http://www.ruanyifeng.com/blog/2014/05/oauth_2_0.html
- OAuth 2.0 的一个简单解释 http://www.ruanyifeng.com/blog/2019/04/oauth_design.html
- GitHub OAuth 示例教程 http://www.ruanyifeng.com/blog/2019/04/github-oauth.html
  * > A very simple demo of OAuth2.0 using node.js https://github.com/ruanyf/node-oauth-demo

The OAuth Bible http://oauthbible.com/

The Simplest Guide To OAuth 2.0 https://medium.com/@darutk/the-simplest-guide-to-oauth-2-0-8c71bd9a15bb

- An Introduction to OAuth 2 https://www.digitalocean.com/community/tutorials/an-introduction-to-oauth-2
- Authorize access to Azure Active Directory web applications using the OAuth 2.0 code grant flow https://docs.microsoft.com/en-us/azure/active-directory/develop/v1-protocols-oauth-code

## OAuth Bearer Token

RFC 6750: OAuth 2.0 Bearer Token Usage https://oauth.net/2/bearer-tokens/

- OAuth 2.0: Bearer Token Usage https://www.cnblogs.com/XiongMaoMengNan/p/6785155.html
- 四，接口认证方式：Bearer Token https://www.jianshu.com/p/8f7009456abc
- OAuth 2.0：Bearer Token、MAC Token区别 https://www.cnblogs.com/cag2050/p/7607609.html

## 待命名

What exactly is OAuth (Open Authorization)? https://stackoverflow.com/questions/4201431/what-exactly-is-oauth-open-authorization

What's the difference between OpenID and OAuth? https://stackoverflow.com/questions/1087031/whats-the-difference-between-openid-and-oauth

What is an Endpoint? https://stackoverflow.com/questions/2122604/what-is-an-endpoint
> "All of the answers posted so far are correct, an endpoint is simply one end of a communication channel."
>> 之前在别的地方看到过，不过已经忘了在哪看的了（但是并不是和OAuth相关的，**因为endpoint是一个general的概念**），于是又查了一下，找到了这个链接。endpoint这个名字本身就是一个很形象的描述，**这里的end其实就是指一次communication的end**：比如手机就是一个endpoint，信息流动到手机以后不会再有下一个结点需要通信了（数据在手机里处理完以后再发回去当然不算了，因为这已经算是信息/通信从终点返回了）。

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# notes of OAuth RFC's

# 1. Terminology

## Main Entity

| Name | Meaning | Explaination |
|:--:|--|--|
| resource owner | An entity capable of granting access to a protected resource. When the resource owner is a person, it is referred to as an end-user. | `资源拥有者`：其实质就是普通的用户（user）。用户将其资源（数据）存储到可靠的大型服务提供商，但是用户又需要不太可靠的小型服务商访问其资源（数据）。 |
| resource server | The server hosting the protected resources, capable of accepting and responding to protected resource requests using access tokens. | `资源服务器`：其实质是具有权威性，并掌握用户数据的大型服务提供商，如微信。 |
| client | An application making protected resource requests on behalf of the resource owner and with its authorization.  The term "client" does not imply any particular implementation characteristics (e.g., whether the application executes on a server, a desktop, or other devices). | `客户（端）`：这个是比较容易迷惑的地方，Client在很多场合和User是一种说法。**但是在这里，Client是指提供各类服务但是又没有掌握用户数据的小型服务提供商**，比如某个提供在线PDF文件标注服务的小公司。 |
| authorization server | The server issuing access tokens to the client after successfully authenticating the resource owner and obtaining authorization. | `认证服务器`：一个用来认证用户（or 资源拥有者），并为客户端（or 第三方服务商）提供access token的服务器。通常情况下该服务器处于resource server（即可信的大型服务商）的控制中。 |

## Minor Entity

| Name | Meaning | Explaination |
|:--:|--|--|
| user-agent | | 一般指处于客户控制中的代理界面，最常见的形式即为浏览器。 |
| Web-Hosted Client Resource | | 在implicit grant方式中用于将client的脚本或带脚本的web页面发送给客户。 |

## Credentials or Proofs

| Name | Meaning | Explaination |
|:--:|--|--|
| Authorization Grant | An authorization grant is a credential representing the resource owner's authorization (to access its protected resources) used by the client to obtain an access token. | 其实质是客户端（小服务商）从用户处获得的凭证。凭借该凭证，客户端可以进一步从authorization server处获得Access Token以及可选的Fresh Token。 |
| Access Token | Access tokens are credentials used to access protected resources. An access token is a string representing an authorization issued to the client. The string is usually opaque to the client. Tokens represent specific scopes and durations of access, granted by the resource owner, and enforced by the resource server and authorization server. | 其实质是客户端通过了认证服务器的验证后（一般以Authorization Grant作为凭据），从认证服务器处获得的凭证。凭借该凭证，客户端可以访问资源服务器获得用户的资源。 |
| Refresh Token | Refresh tokens are credentials used to obtain access tokens. Refresh tokens are issued to the client by the authorization server and are used to obtain a new access token when the current access token becomes invalid or expires, or to obtain additional access tokens with identical or narrower scope (access tokens may have a shorter lifetime and fewer permissions than authorized by the resource owner). | 用户在获得Access Token的时候，认证服务器可以有选择地将Refresh Token一起发放。其作用是再次申请Access Token时可以无需再向用户申请Authorization Grant。 |

# 2. Flowchart

## 2.1 Basic OAuth 2.0 Protocol

```
     +--------+                               +---------------+
     |        |--(A)- Authorization Request ->|   Resource    |
     |        |                               |     Owner     |
     |        |<-(B)-- Authorization Grant ---|               |
     |        |                               +---------------+
     |        |
     |        |                               +---------------+
     |        |--(C)-- Authorization Grant -->| Authorization |
     | Client |                               |     Server    |
     |        |<-(D)----- Access Token -------|               |
     |        |                               +---------------+
     |        |
     |        |                               +---------------+
     |        |--(E)----- Access Token ------>|    Resource   |
     |        |                               |     Server    |
     |        |<-(F)--- Protected Resource ---|               |
     +--------+                               +---------------+

                     Figure 1: Abstract Protocol Flow
```

## 2.2 Flowchart for the four basic kinds of `Authorization Grant`

### Authorization Code Flow

>  The authorization code is obtained by using an authorization server as an intermediary between the client and resource owner.  Instead of requesting authorization directly from the resource owner, the client directs the resource owner to an authorization server (via its user-agent as defined in [RFC2616]), which in turn directs the resource owner back to the client with the authorization code.

> The authorization code provides a few important security benefits, such as the ability to authenticate the client, as well as the transmission of the access token directly to the client without passing it through the resource owner's user-agent and potentially exposing it to others, including the resource owner.

```
     +----------+
     | Resource |
     |   Owner  |
     |          |
     +----------+
          ^
          |
         (B)
     +----|-----+          Client Identifier      +---------------+
     |         -+----(A)-- & Redirection URI ---->|               |
     |  User-   |                                 | Authorization |
     |  Agent  -+----(B)-- User authenticates --->|     Server    |
     |          |                                 |               |
     |         -+----(C)-- Authorization Code ---<|               |
     +-|----|---+                                 +---------------+
       |    |                                         ^      v
      (A)  (C)                                        |      |
       |    |                                         |      |
       ^    v                                         |      |
     +---------+                                      |      |
     |         |>---(D)-- Authorization Code ---------'      |
     |  Client |          & Redirection URI                  |
     |         |                                             |
     |         |<---(E)----- Access Token -------------------'
     +---------+       (w/ Optional Refresh Token)

   Note: The lines illustrating steps (A), (B), and (C) are broken into
   two parts as they pass through the user-agent.

                     Figure 3: Authorization Code Flow
```

### Implicit Grant Flow

> The implicit grant is a simplified authorization code flow optimized for clients implemented in a browser using a scripting language such as JavaScript.  In the implicit flow, instead of issuing the client an authorization code, the client is issued an access token directly (as the result of the resource owner authorization). The grant type is implicit, as no intermediate credentials (such as an authorization code) are issued (and later used to obtain an access token).

```
     +----------+
     | Resource |
     |  Owner   |
     |          |
     +----------+
          ^
          |
         (B)
     +----|-----+          Client Identifier     +---------------+
     |         -+----(A)-- & Redirection URI --->|               |
     |  User-   |                                | Authorization |
     |  Agent  -|----(B)-- User authenticates -->|     Server    |
     |          |                                |               |
     |          |<---(C)--- Redirection URI ----<|               |
     |          |          with Access Token     +---------------+
     |          |            in Fragment
     |          |                                +---------------+
     |          |----(D)--- Redirection URI ---->|   Web-Hosted  |
     |          |          without Fragment      |     Client    |
     |          |                                |    Resource   |
     |     (F)  |<---(E)------- Script ---------<|               |
     |          |                                +---------------+
     +-|--------+
       |    |
      (A)  (G) Access Token
       |    |
       ^    v
     +---------+
     |         |
     |  Client |
     |         |
     +---------+

   Note: The lines illustrating steps (A) and (B) are broken into two
   parts as they pass through the user-agent.

                       Figure 4: Implicit Grant Flow
```

### Resource Owner Password Credentials Flow

> The method through which the client obtains the resource owner credentials is beyond the scope of this specification. The client MUST discard the credentials once an access token has been obtained.

```
     +----------+
     | Resource |
     |  Owner   |
     |          |
     +----------+
          v
          |    Resource Owner
         (A) Password Credentials
          |
          v
     +---------+                                  +---------------+
     |         |>--(B)---- Resource Owner ------->|               |
     |         |         Password Credentials     | Authorization |
     | Client  |                                  |     Server    |
     |         |<--(C)---- Access Token ---------<|               |
     |         |    (w/ Optional Refresh Token)   |               |
     +---------+                                  +---------------+

            Figure 5: Resource Owner Password Credentials Flow
```

### Client Credentials Flow

> The client credentials (or other forms of client authentication) can be used as an authorization grant when the authorization scope is limited to the protected resources under the control of the client, or to protected resources previously arranged with the authorization server. Client credentials are used as an authorization grant typically when the client is acting on its own behalf (the client is also the resource owner) or is requesting access to protected resources based on an authorization previously arranged with the authorization server.

```
     +---------+                                  +---------------+
     |         |                                  |               |
     |         |>--(A)- Client Authentication --->| Authorization |
     | Client  |                                  |     Server    |
     |         |<--(B)---- Access Token ---------<|               |
     |         |                                  |               |
     +---------+                                  +---------------+

                     Figure 6: Client Credentials Flow
```

## 2.3 Flowchart for the extension(s) of `Authorization Grant`

```
      +----------+                                +----------------+
      |          |>---(A)-- Client Identifier --->|                |
      |          |                                |                |
      |          |<---(B)-- Device Code,      ---<|                |
      |          |          User Code,            |                |
      |  Device  |          & Verification URI    |                |
      |  Client  |                                |                |
      |          |  [polling]                     |                |
      |          |>---(E)-- Device Code,      --->|                |
      |          |          & Client Identifier   |                |
      |          |                                |  Authorization |
      |          |<---(F)-- Access Token      ---<|     Server     |
      +----------+   (& Optional Refresh Token)   |                |
            v                                     |                |
            :                                     |                |
           (C) User Code & Verification URI       |                |
            :                                     |                |
            v                                     |                |
      +----------+                                |                |
      | End user |                                |                |
      |    at    |<---(D)-- End user reviews  --->|                |
      |  Browser |          authorization request |                |
      +----------+                                +----------------+

                    Figure 1: Device Authorization Flow
```

## 2.4 Flowchart for the refresh token process

```
  +--------+                                           +---------------+
  |        |--(A)------- Authorization Grant --------->|               |
  |        |                                           |               |
  |        |<-(B)----------- Access Token -------------|               |
  |        |               & Refresh Token             |               |
  |        |                                           |               |
  |        |                            +----------+   |               |
  |        |--(C)---- Access Token ---->|          |   |               |
  |        |                            |          |   |               |
  |        |<-(D)- Protected Resource --| Resource |   | Authorization |
  | Client |                            |  Server  |   |     Server    |
  |        |--(E)---- Access Token ---->|          |   |               |
  |        |                            |          |   |               |
  |        |<-(F)- Invalid Token Error -|          |   |               |
  |        |                            +----------+   |               |
  |        |                                           |               |
  |        |--(G)----------- Refresh Token ----------->|               |
  |        |                                           |               |
  |        |<-(H)----------- Access Token -------------|               |
  +--------+           & Optional Refresh Token        +---------------+

               Figure 2: Refreshing an Expired Access Token
```


