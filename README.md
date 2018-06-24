### Hakkında

Ubuntu tabanlı sistemlerde kullanılmak üzere oluşturulmuştur. Cron tanımlanarak yapılan işlemler otomatize edilebilir.

```sh
0 2 * * * /bin/bash /scriptin-bulundugu-dizin/optimization.sh >/dev/null 2>&1
```
  - İlk kurulumda gelen gereksiz paketlerin kaldırılmasını sağlar.
  - Update/upgrade işlemleri yapar.
  - Eski Linux kernellerini kaldırır.
  - Ssd diskler için trim işlemini yapar.
  - Memory cache, node, swap temizliği yapar.

### Kullanım

Scriptin çalıştırılabilmesi için root yetkisinin olması gerekmektedir.

```sh
$ bash optimization.sh
```
