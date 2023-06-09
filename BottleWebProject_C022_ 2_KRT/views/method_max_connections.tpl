% rebase('layout.tpl', year=year, graph_count=graph_count, k_step=k_step, graph_data=graph_data, main_graph=main_graph, is_valid_graph=is_valid_graph, res=res, route_data=route_data)

<link rel="stylesheet" type="text/css" href="/static/content/method_max_connections.css" />

<div class="background">
  <img class="back_image" src="/static/images/graph_wallpaper2.jpg" />
</div>

<div class="wrapper">
    <div class="info-container">
        <h1><strong>Требуется найти в графе вершины с наибольшим окружением</strong></h1>
        <p>Реализация алгоритма поиска в графе вершин, имеющих наибольшее окружение.</p>
        <p>Вычисляются последовательно степени матрицы смежности A2, А3, …, Ak и соответствующие им матрицы ограниченных достижимостей R2, R3, …, Rk.</p>
        <p>k – максимальное количество ярусов, задаваемое пользователем.</p>
        <h2>Метод решения задачи:</h2>
        <p>Возьмем за основу следующую матрицу:</p>
        <div>
         <img class="graph-image" src="/static/images/max_con_theory1.png" alt="theory 1">
        </div>
        <p class="graph-image-text">Рисунок 1 – Матрица смежности графа</p>
        <p>Выполним расчеты для шага k=4</p>
        <p>Вычислим степени матрицы:</p>
        <div>
         <img class="graph-image" src="/static/images/max_con_theory2.png" alt="theory 2">
        </div>
        <p class="graph-image-text">Рисунок 2 – Булевы степени матрицы</p>
        <p>Матрица E1 показывает, в какие вершины мы можем попасть за 1 шаг.</p>
        <p>Матрица E2 показывает, в какие вершины мы можем попасть за 2 шаг.</p>
        <p>Матрица E3 показывает, в какие вершины мы можем попасть за 3 шаг.</p>
        <p>Матрица E4 показывает, в какие вершины мы можем попасть за 4 шаг.</p>
        <p>Если посмотреть, то за второй шаг мы попадаем во все вершины, в которые не попали за первый шаг.</p>
        <p>Получим матрицу достижимости. Она показывает, есть ли путь из вершины a в вершину b..</p>
        <div>
         <img class="graph-image" src="/static/images/max_con_theory3.png" alt="theory 3">
        </div>
        <p class="graph-image-text">Рисунок 3 – Матрица достижимости</p>
        <p>По полученной матрице достижимостей мы можем найти точки, обладающие наибольшим окружением (те, где больше всего 1 в строках)</p>
        <p>Такими точками являются: 1, 3, 4</p>
        <div class="input-info-container">
            <h2>Входные данные</h2>
            <p>Форма ввода в качестве входных значений принимает 2 аргументa:
                <ol>
                    <li class="info-li"><strong>Количество вершин графа.</strong></li>
                    <li class="info-li"><strong>Глубина яруса ддля поиска k.</strong></li>
                </ol>
            </p>
            <p>
                Поля ввода ограничены диапазоном значений от 2 до 20 включительно.
            </p>
            <p>
                Также на форме присутствуют две кнопки:
                <ul>
                    <li class="info-li"><strong>Кнопка "Построить матрицу"</strong> - отвечает за построение таблицы смежности графа;</li>
                    <li class="info-li"><strong>Кнопка "Заполнить случайно"</strong> - отвечает заполнение таблицы смежности случайными значениями.</li>
                </ul>
            </p>
            <p>После построения таблицы смежности графа и(или) заполнением ее случайно, пользователь может самостоятельно заполнить(изменить) данные в таблице.</p>
        </div>
        <div class="output-info-container">
            <h2>Выходные данные</h2>
            <p>
                В качестве выходных данных, будут выведены:
                <ol>
                    <li class="info-li"><strong>Матрица ограниченных достижимостей точек на введенном ранее k-ярусе;</strong></li>
                    <li class="info-li"><strong>Перечисление точек с наибольшим окружением на k-ярусе;</strong></li>
                </ol>
            </p>
        </div>
    </div>
    <div class="info-container">
        <div class="form-container">
            <form action="/method_max_connections" method="post">
                <div class="form-input">
                    <label for="graph_count">Введите размерность графа:</label>
                    <input type="number" id="graph_count" value="{{graph_count}}" required min="2" max="20" pattern="[0-9]+" name="graph_count" placeholder="Размер матрицы смежности графа">
                </div>
                <div class="form-input">
                    <label for="k_step">Введите количество ярусов:</label>
                    <input type="number" id="k_step" value="{{k_step}}" required min="1" max="5" name="k_step" placeholder="Глубина шага k">
                </div>
                <div class="form-buttons">
                    <button class="btn" type="submit" name="form" value="Send2">Построить матрицу</button>
                    <button class="btn" type="submit" name="form" value="Random2">Заполнить случайно</button>
                </div>
            </form>
        </div>
        %if int(graph_count) > 0:
        <div class="table-container">
            <form action="/method_max_connections" method="post">
                <table name="graph_data" class="graph-table">
                    <caption>Таблица смежности графа:</caption>
                    <thead>
                        <tr>
                            <th></th>
                            %for i in range(int(graph_count)):
                                <th>{{i+1}}</th>
                            %end
                        </tr>
                    </thead>
                    <tbody>
                        %for i in range(int(graph_count)):
                            <tr>
                                <th>{{i+1}}</th>
                                %for j in range(int(graph_count)):
                                    %if graph_data:
                                        %if graph_data[i][j] == 0:
                                            <td style="background-color: #d97676;"><input style="background-color: #d97676;" type="number" name="{{i}}{{j}}g" value="{{graph_data[i][j]}}" required min="0" max="1" pattern="[01]" maxlength="1"></td>
                                        %else:
                                            <td style="background-color: #78d975;"><input style="background-color: #78d975;" type="number" name="{{i}}{{j}}g" value="{{graph_data[i][j]}}" required min="0" max="1" pattern="[01]" maxlength="1"></td>
                                        %end
                                    %else:
                                        <td style="background-color: #d97676;"><input style="background-color: #d97676;" type="number" name="{{i}}{{j}}g" value="0" required min="0" max="1" pattern="[01]" maxlength="1"></td>
                                    %end
                                %end
                            </tr>
                        %end
                    </tbody>
                </table>
                <p class="confirm">
                    <button class="btn" type="submit" name="form" value="Confirm2">Посчитать</button>
                </p>
            </form>
        </div>
        %end
    </div>
    %if len(route_data) > 0:
        <div class="info-container">
                <div class="table-container">
                    <form action="/method_max_connections" method="post">
                        <table name="limit_reachability" class="graph-table">
                            <caption>Матрица ограниченных достижимостей {{k_step}} - шага</caption>
                            <thead>
                                <tr>
                                    <th></th>
                                    %for i in range(int(graph_count)):
                                        <th>{{i+1}}</th>
                                    %end
                                </tr>
                            </thead>
                            <tbody>
                                %for i in range(int(graph_count)):
                                    <tr>
                                        <th>{{i+1}}</th>
                                        %for j in range(int(graph_count)):
                                            %if graph_data:
                                                <td style="background-color: #DCDCDC;"><p>{{route_data[i][j]}}</p></td>
                                            %end
                                        %end
                                    </tr>
                                %end
                            </tbody>
                        </table>
                    </form>
                </div>

            %if len(res) > 1:
                <div class="table-container">
                    <form action="/method_max_connections" method="post">
                        <p>Вершины с наибольшим окружением: {{res}}</p>
                    </form>
                </div>
            %end
        </div>
        %end
</div>