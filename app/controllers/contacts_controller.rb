class ContactsController < ApplicationController
  before_action :require_logged_in_user
  before_action :set_contact, only: %i[ show edit update destroy ]

  # GET /contacts or /contacts.json
  def index
    @contacts = current_user.contacts
  end

  # GET /contacts/1 or /contacts/1.json
  def show; end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # POST /contacts or /contacts.json
  def create
    @contact = current_user.contacts.build(contact_params)
    if @contact.save
      flash[:success] = "Contato criado com sucesso!"
      redirect_to user_contacts_path
    else
      render "new"
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = current_user.contacts.find(params[:id])
    if @contact.nil?
      flash[:danger] = "Contato não encontrado!"
      redirect_to user_contacts_path(current_user)
    end
  end

  # PATCH/PUT /contacts/1 or /contacts/1.json
  def update
    @contact = current_user.contacts.find(params[:id])
    if @contact.update(contact_params)
      flash[:success] = "Contato atualizado com sucesso!"
      redirect_to user_contacts_path
    else
      render "edit"
    end
  end

  # DELETE /contacts/1 or /contacts/1.json
  def destroy
    @contact = current_user.contacts.find(params[:id])
    if @contact.destroy
      flash[:success] = "Contato excluído com sucesso!"
      redirect_to user_contacts_path
    else
      flash[:danger] = "Contato não encontrado!"
      redirect_to user_contacts_path(current_user)
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:name, :phone)
    end
end
