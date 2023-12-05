<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="catalogue">
        <div class="catalogueFilter">
            <h1 style="width: 100%; text-align: center">Фильтры</h1>
            <hr>
            <a class="btn btn-dark mt-1 mb-3" style="text-align: center; width: 100%"
               data-toggle="collapse" href="#filter" role="button"
               aria-expanded="true" aria-controls="filter, sort">
                Фильтр
            </a>
            <div class="collapse mb-3" id="filter" style="">
                <form action="/" method="get" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="brand">Бренд</label>
                        <select style="margin-bottom: 10px" name="brand" id="searchBrand" class="form-control">-->
                            <option value=""></option>
                            <#list brands as brand>
                                <option value="${brand}" <#if brandFilter?has_content && brandFilter == brand>selected</#if>>${brand}</option>
                            </#list>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="material">Материал</label>
                        <select style="margin-bottom: 10px" name="material" id="searchMaterial" class="form-control">-->
                            <option value=""></option>
                            <#list materials as material>
                                <option value="${material}" <#if materialFilter?has_content && materialFilter == material>selected</#if>>${material}</option>
                            </#list>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="size">Размер</label>
                        <select id="searchSize" name="size" class="form-control">
                            <option value=""></option>
                            <#list sizes as size>
                                <option value="${size}" <#if sizeFilter?has_content && sizeFilter == size>selected</#if>>${size}</option>
                            </#list>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="searchPrice">Цена</label>
                        <div class="input-group mb-3">
                            <input type="number" name="minPrice" class="form-control" placeholder="От " <#if minPrice??>value="${minPrice}"</#if> min="0"/>
                            <input type="number" name="maxPrice" class="form-control" placeholder="До " <#if maxPrice??>value="${maxPrice}"</#if> min="0" />
                            <div class="input-group-append">
                                <span class="input-group-text">₽</span>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="sortType" <#if !sortType?? || sortType == "cheapFirst">value="cheapFirst" selected<#else> value="${sortType}" </#if>
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <button type="submit" style="width: 100%" class="btn btn-dark">Применить</button>
                </form>
            </div>
            <a class="btn btn-dark mt-1 mb-3" style="text-align: center; width: 100%"
               data-toggle="collapse" href="#sort" role="button"
               aria-expanded="true" aria-controls="filter, sort">
                Сортировка
            </a>
            <div class="collapse mb-3" id="sort" style="">
                <form action="/" method="get" enctype="multipart/form-data">
                    <div class="form-check">
                        <input type="radio" name="sortType" id="sortCheapFirst" value="cheapFirst" <#if !sortType?? || sortType == "cheapFirst">checked</#if>>
                        <label for="sortCheapFirst" class="form-check-label">Сначала недорогие</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" name="sortType" id="sortExpensiveFirst" value="expensiveFirst" <#if sortType??> <#if sortType == "expensiveFirst">checked</#if></#if>>
                        <label for="sortExpensiveFirst" class="form-check-label">Сначала дорогие</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" name="sortType" id="sortAZ" value="az" <#if sortType??> <#if sortType == "az">checked</#if></#if>>
                        <label for="sortAZ" class="form-check-label">По алфавиту (A-Z)</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" name="sortType" id="sortZA" value="za" <#if sortType??> <#if sortType == "za">checked</#if></#if>>
                        <label for="sortZA" class="form-check-label">По алфавиту (Z-A)</label>
                    </div>
                    <input type="hidden" name="brand" <#if brandFilter??>value="${brandFilter}"</#if>>
                    <input type="hidden" name="material" <#if materialFilter??>value="${materialFilter}"</#if>>
                    <input type="hidden" name="size" <#if sizeFilter??>value="${sizeFilter}"</#if>>
                    <input type="hidden" name="minPrice" <#if brandFilter??>value="${minPrice}"</#if>>
                    <input type="hidden" name="maxPrice" <#if brandFilter??>value="${maxPrice}"</#if>>
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <button type="submit" style="width: 100%" class="btn btn-dark">Применить</button>
                </form>
            </div>
        </div>
        <div class="cataloguePage">
            <h1 style="text-align: center">Каталог</h1>
            <hr>
            <form method="get" action="/">
                <div class="form-row">
                    <div style="margin-bottom: 10px" class="form-group loop">
                        <input type="text" name="searchWord" placeholder="Поиск"
                               <#if searchWord??>value="${searchWord}"</#if> class="form-control" id="searchWord">
                        <button type="submit" class="search-button"><i class="fas fa-search"></i></button>
                    </div>
                </div>
            </form>
            <hr>
            <div class="card-columns d-flex items">
                <#list products as product>
                    <a href="/product/${product.id?c}" class="product-link oneItem">
                        <div class="card text-white bg-dark my-3 product">
                            <div class="itemImage">
                                <img src="/images/${product.previewImageId?c}" alt="previewImage">
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">${product.brand}</h5>
                                <p class="card-text">${product.title}</p>
                            </div>
                            <div class="card-footer">
                                ${product.price} ₽
                            </div>
                        </div>
                    </a>
                <#else>
                    <h1 style="text-align: center">Не найдено</h1>
                </#list>
            </div>
        </div>
    </div>
</@t.template>