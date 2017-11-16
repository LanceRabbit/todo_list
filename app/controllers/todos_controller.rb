class TodosController < ApplicationController
  ##指定這個方法只會在 show、edit、update 及 destroy 動作中運作。
  before_action :set_todo, :only => [:show, :edit, :update, :destroy]

  def index
    ##將資料表Todo的資料設定給予 @todos
    ##實例變數 = 資料表
    # @todos = Todo.all
    # 依到期日 (due_date) 近到遠，取得 todos
    @todos = Todo.order(due_date: :asc)
  end
  def new 
    @todo = Todo.new
  end

  def create
   # 依傳入參數 new 一個 Todo 實例
    @todo = Todo.new(todo_params)
    # 如果驗證成功，則儲存，並回到列表頁，告知成功新增
    # 如果驗證失敗，則不儲存，並保留已填寫資訊，回到 new，繼續填寫
    if @todo.save
      # 跳出通知訊息，告知成功新增
      # 若要使用請打開 application.html.erb 的 flash tag
      # flash[:notice] = 'List was successfully created !!'
      # 重新發出 request，導往列表頁。對瀏覽器來說會重整頁面
      
      # 重新導向 index 頁面  _path _url 都可以導向首頁
      # redirect_to todos_path
      # redirect_to todos_url
      # 若導向外部建議使用url , 內部則使用path
      redirect_to todos_path
    else
      # 驗證失敗時，將 @todo 傳入 new.html.erb 做 render
      # 保留已填寫資料
      render :new
    end
  end

  # 原先此 action 內的代碼:
  # @todo = Todo.find(params[:id])
  # 此行的作用已被 before_action :set_todo 取代
  def show 

  end

  # 原先此 action 內的代碼:
  # @todo = Todo.find(params[:id])
  # 此行的作用已被 before_action :set_todo 取代
  def edit

  end

  def update
    
    @todo.update_attributes(todo_params)
    if @todo.update_attributes(todo_params)

      # flash[:notice] = "event was successfully updated"
      # 回到特定頁面
      redirect_to todo_path(@todo)
    else
      # 仍然停留在當前action裡
      render  :action => :edit
    end

  end

 def destroy
    # @todo = Todo.find(params[:id])
    # 此行的作用已被 before_action :set_todo 取代

    # Todo#can_desctroy? 定義在 todo.rb 裡
    # 如果可以刪除，則刪除，並回到列表頁，告知刪除成功
    # 如果不允許刪除，則回到列表頁，並告知過期
    if (@todo.can_destroy?)
      @todo.destroy
      # 跳出警告訊息，告知成功刪除
      # flash[:alert] = 'List was successfully deleted !!'
      # 重新發出 request，導往列表頁。對瀏覽器來說會重整頁面
      redirect_to todos_path
    else
      # 跳出警告訊息，告知過期
      # flash[:alert] = 'List is overdue, can not be deleted !!'
      redirect_to todos_path
    end
  end


  # 設定私有方法
  private

  # edit, #update, #destroy 
  # 以上三個 actions 執行之前，先找出指定ID的todo
  # 提取出方法 before_action :set_todo  
  def set_todo
    @todo = Todo.find(params[:id])
  end

  # Term: strong parameters, > Rails 4 only.
  # 基於安全性考量，不可以直接將未經允許 (permit) 的參數傳入 model 做新增或修改
  # 可視需求在各 controller 分開獨立指定允許的內容
  def todo_params
    # params 變數是 Rails 在消化完 http request 後，所留下的 controller 常用參數群
    # #require 方法裡的 symbol 與 form 送回的物件名稱相同
    # #permit  方法裡的 symbol 與 form 送回的物件欄位名稱相同
    params.require(:todo).permit(:title, :due_date, :note)
  end
end
