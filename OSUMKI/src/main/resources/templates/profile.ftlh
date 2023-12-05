<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="container account">
        <h1 style="text-align: center">Личный кабинет</h1>
        <hr>
        <br>
        <div style="text-align: center">
            <#if user.isAdmin()>
                <img src="/static/images/adminAvatar.png"
                     style="border:2px solid black; border-radius: 20px" height="120" width="120" alt="АдминПрофиль">
            <#elseif user.isModerator()>
                <img src="/static/images/moderatorAvatar.png"
                     style="border:2px solid black; border-radius: 20px" height="120" width="120" alt="АдминПрофиль">
            <#else>
                <div style="width: 100%; display: flex; justify-content: center">
                    <div style="font-family: 'Marck Script', serif; background-color: white; border: 2px solid black; border-radius: 20px; width: 120px; height: 120px;>
                text-align: center; line-height: 120px; font-size: 60px; user-select: none;">
                        ${user.name?substring(0, 1)}
                    </div>
                </div>
            </#if>
            <br>
            <br>
            <h2>${user.name}</h2>
            <br>
            Электронная почта: <b>${user.email}</b>
            <br>
            Номер телефона: <b>${user.phoneNumber}</b>
            <br>
            <br>


            <#if user.isAdmin() || user.isModerator()>
                <div style="display: flex; flex-direction: column; width: 100%; align-items: center">
                    <a class="btn btn-dark mt-3 mb-3" style="text-align: center; width: 350px"
                       data-toggle="collapse" href="#collapseExample" role="button"
                       aria-expanded="true" aria-controls="collapseExample">
                        Добавить новый товар
                    </a>
                    <div class="collapse mb-3  profileButtons" id="collapseExample" style="">
                        <form action="/product/create" method="post" enctype="multipart/form-data">
                            <div class="form-group">
                                <label for="brand">Бренд </label>
                                <div class="TestInput">
                                    <input required id="focusInput1" name="brand" class="InputSelect" type="text"/>
                                    <img class="Triangle" src="/static/images/triangle.png" alt="list">
                                    <div class="Select SelectBrand">
                                        <#list brands as brand>
                                            <button id="varBtn" class="VarBtn"
                                                    onclick="setInput1(this.innerHTML)">${brand}</button>
                                        </#list>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="title">Модель </label>
                                <div class="TestInput">
                                    <input required id="focusInput2" name="title" class="InputSelect" type="text"/>
                                    <img class="Triangle" src="/static/images/triangle.png" alt="list">
                                    <div class="Select SelectTitle">
                                        <#list titles as title>
                                            <button id="varBtn" class="VarBtn"
                                                    onclick="setInput2(this.innerHTML, this.id)">${title}</button>
                                        </#list>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="description">Описание </label>
                                <div class="TestInput">
                                    <input required name="description" class="InputSelect" type="text"/>
                                    <img class="Triangle" src="/static/images/triangle.png" alt="list">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="material">Материал </label>
                                <div class="TestInput">
                                    <input required id="focusInput3" name="material" class="InputSelect" type="text"/>
                                    <img class="Triangle" src="/static/images/triangle.png" alt="list">
                                    <div class="Select SelectMaterial">
                                        <#list materials as material>
                                            <button id="varBtn" class="VarBtn"
                                                    onclick="setInput3(this.innerHTML)">${material}</button>
                                        </#list>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="size">Размер </label>
                                <div class="TestInput">
                                    <input required id="focusInput4" name="size" class="InputSelect" type="text"/>
                                    <img class="Triangle" src="/static/images/triangle.png" alt="list">
                                    <div class="Select SelectSize">
                                        <#list sizes as size>
                                            <button id="varBtn" class="VarBtn"
                                                    onclick="setInput4(this.innerHTML)">${size}</button>
                                        </#list>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="price">Цена </label>
                                <div class="input-group mb-3">
                                    <input type="number" style="margin-bottom: 10px" required class="form-control"
                                           id="price" name="price">
                                    <div class="input-group-append">
                                        <span class="input-group-text">₽</span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="custom-file">
                                    <label class="custom-file-label" for="file1">Первая фотография к товару</label>
                                    <input required type="file" style="margin-bottom: 20px" name="file1" id="file1">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="custom-file">
                                    <label class="custom-file-label" for="file2">Вторая фотография к товару</label>
                                    <input type="file" style="margin-bottom: 20px" name="file2" id="file2">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="custom-file">
                                    <label class="custom-file-label" for="file3">Третья фотография к товару</label>
                                    <input type="file" style="margin-bottom: 10px" name="file3" id="file3">
                                </div>
                            </div>

                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                            <button type="submit" style="width: 100%" class="btn btn-dark">Добавить</button>
                        </form>
                    </div>
                    <#if user.isAdmin()>
                        <a class="btn btn-dark mb-3" style="text-align: center; width: 350px"
                           href="/admin">
                            Панель администратора
                        </a><br>
                    </#if>
                </div>
            </#if>


            <#if !user.isAdmin()>
                <#if user.isConfirmedEmail()>
                    <form action="/confirm" method="get">
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        <button type="submit" style="text-align: center;" class="btn btn-dark mb-2 profileButtons"
                                disabled>
                            Почта подтверждена
                        </button>
                    </form>
                <#else>
                    <form action="/confirm" method="get">
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        <button type="submit" style="text-align: center;" class="btn btn-dark mb-2 profileButtons">
                            Подтвердить почту
                        </button>
                    </form>
                </#if>
            </#if>
            <form action="/logout" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <button type="submit" style="text-align: center;" class="btn btn-danger mb-2 profileButtons">
                    Выйти из аккаунта
                </button>
            </form>

        </div>
    </div>
</@t.template>
