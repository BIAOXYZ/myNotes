
# 出处

Container Registry 【by [Jonathan Johnson](https://www.katacoda.com/javajon)】 https://www.katacoda.com/courses/container-runtimes/container-registries-by-javajon

```        
master $ echo $REGISTRY
127.0.0.1:31500
master $
master $ cd ~ && envsubst < max-breast-cancer-mitosis-detector.yaml > max-breast-cancer-mitosis-detector-modified.yaml
master $
master $ diff max-breast-cancer-mitosis-detector.yaml max-breast-cancer-mitosis-detector-modified.yaml
33c33
<         image: $REGISTRY/max-breast-cancer-mitosis-detector:latest
---
>         image: 127.0.0.1:31500/max-breast-cancer-mitosis-detector:latest
master $
```
