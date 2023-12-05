<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="container productInfo">
        <div class="photoSumkiContainer">
            <div id="myCarousel" style="background-color: #333333; border-radius: 20px;"
                 class="carousel slide carouselContainer" data-ride="carousel">
                <div class="carousel-inner" style="background-color: unset">
                    <#list images as image>
                        <div class="carousel-item <#if image.previewImage>active</#if>" style="height: 500px">
                            <div class="container" style="height: 100%">
                                <div class="carousel-caption" style="height: 100%; top: 0 !important;">
                                    <div style="height: 100%; display: flex; justify-content: center; align-items: center">
                                        <div style="width: 400px; height: 100%; overflow: hidden; position: relative; display: flex; flex-direction: column">
                                            <div style="position: absolute; height: 100%; align-self: center">
                                                <img class="product" style="height: 100%; top: 0;"
                                                     src="/images/${image.id?c}">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </#list>
                </div>
                <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Предыдущее фото</span>
                </a>
                <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Следующее фото</span>
                </a>
            </div>
        </div>

        <hr>
        <p>
        <h1 style="text-align: center">${product.brand} | ${product.title}</h1>
        <#if product.description??>
            <p style="text-align: center; word-break: break-word">${product.description}</p>
        </#if>
        <p style="text-align: center">${product.size}</p>
        <p style="text-align: center">${product.price} ₽</p>

        <hr>
        <div style="display: flex; align-items: center; flex-direction: column">
            <div class="btnContainer" >
                <a href="https://web.telegram.org/k/#@ALEXEY_LELESH" target="_blank" class="btnOrder">
                    <div class="btnIcon tgIcon">
                        <img src="/static/images/tg.png" alt="tg" class="btnImg">
                    </div>
                    <div class="btnText">Заказать</div>
                </a>
            </div>
            <div class="btnContainer" style="margin-top: 20px;">
                <a href="https://api.whatsapp.com/send?phone=79011052601&text=Здравствуйте,%20хочу%20оформить%20заказ!" target="_blank" class="btnOrder">
                    <div class="btnIcon whatsappIcon">
                        <img src="/static/images/wa.png" alt="whatsapp" class="btnImg">
                    </div>
                    <div class="btnText">Заказать</div>
                </a>
            </div>
        </div>




        <hr>
        <#if user.isAdmin() || user.isModerator()>
            <div style="display: flex; flex-direction: column; width: 100%; align-items: center">
                <a class="btn btn-dark mt-3 mb-3" style="text-align: center; width: 350px"
                   data-toggle="collapse" href="#collapseExample" role="button"
                   aria-expanded="true" aria-controls="collapseExample">
                    Редактировать
                </a>
                <div class="collapse mb-3  profileButtons" id="collapseExample" style="">
                    <form action="/product/edit/${product.id?c}" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="brand">Бренд </label>
                            <div class="TestInput">
                                <input required name="brand" class="InputSelect" type="text" value="${product.brand}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="title">Модель </label>
                            <div class="TestInput">
                                <input required name="title" class="InputSelect" type="text" value="${product.title}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="description">Описание </label>
                            <div class="TestInput">
                                <input required name="description" class="InputSelect" type="text"
                                       <#if product.description??>value="${product.description}"</#if>/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="material">Материал </label>
                            <div class="TestInput">
                                <input required name="material" class="InputSelect" type="text"
                                       value="${product.material}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="size">Размер </label>
                            <div class="TestInput">
                                <input required name="size" class="InputSelect" type="text" value="${product.size}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="price">Цена </label>
                            <div class="input-group mb-3">
                                <input type="number" style="margin-bottom: 10px" required class="form-control"
                                       id="price" name="price" value="${product.price?c}">
                                <div class="input-group-append">
                                    <span class="input-group-text">₽</span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" style="margin-bottom: 25px">
                            <div class="custom-file" style="display:flex; flex-direction:column; align-items: center">
                                <label class="custom-file-label" for="file1">Первая фотография к товару</label>
                                <input type="file" style="margin-bottom: 20px; margin-left: 45px" name="file1"
                                       id="file1">
                                <#if images[0]??>
                                    <img style="height: 200px; width: 200px" src="/images/${images[0].id?c}"
                                         alt="Product Image 1">
                                </#if>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group" style="margin-top: 25px; margin-bottom: 25px">
                            <div class="custom-file" style="display:flex; flex-direction:column; align-items: center">
                                <label class="custom-file-label" for="file2">Вторая фотография к товару</label>
                                <input type="file" style="margin-bottom: 20px; margin-left: 45px" name="file2"
                                       id="file2">
                                <#if images[1]??>
                                    <img style="height: 200px; width: 200px" src="/images/${images[1].id?c}"
                                         alt="Product Image 2">
                                    <input type="checkbox" name="deleteImage" value="${images[1].id?c}"> Удалить
                                </#if>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group" style="margin-top: 25px; margin-bottom: 50px">
                            <div class="custom-file" style="display:flex; flex-direction:column; align-items: center">
                                <label class="custom-file-label" for="file3">Третья фотография к товару</label>
                                <input type="file" style="margin-bottom: 20px; margin-left: 45px" name="file3"
                                       id="file3">
                                <#if images[2]??>
                                    <img style="height: 200px; width: 200px" src="/images/${images[2].id?c}"
                                         alt="Product Image 3">
                                    <input type="checkbox" name="deleteImage" value="${images[2].id?c}"> Удалить
                                </#if>
                            </div>
                        </div>
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        <button type="submit" style="width: 100%" class="btn btn-dark">Подтвердить</button>
                    </form>
                </div>
            </div>
            <div style="align-items: center; display: flex; flex-direction: column">
                <form action="/product/delete/${product.id?c}" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <button type="submit" style="text-align: center; width: 350px" class="btn btn-danger mb-2">
                        Удалить
                    </button>
                </form>
            </div>
        </#if>
    </div>
</@t.template>
