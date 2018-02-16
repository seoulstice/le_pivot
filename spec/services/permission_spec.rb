require 'rails_helper'

describe Permission do
  describe '::granted?' do

    context 'for public actions' do
      it 'returns true any user' do
        stub_config({ controller: { action: Permission::PUBLIC }})
        visitor = Permission.granted?(:controller, :action, nil)
           user = Permission.granted?(:controller, :action, create(:user))
  store_manager = Permission.granted?(:controller, :action, create(:store_manager))
    store_admin = Permission.granted?(:controller, :action, create(:store_admin))
 platform_admin = Permission.granted?(:controller, :action, create(:platform_admin))

        expect([visitor, user, store_manager, store_admin, platform_admin]).to all(be true)
      end
    end
    context 'for private actions' do
      it 'returns true only for specified roles' do
        stub_config({ controller: { action: %i{ store_manager platform_admin } }})
       visitor = Permission.granted?(:controller, :action, nil)
          user = Permission.granted?(:controller, :action, create(:user))
 store_manager = Permission.granted?(:controller, :action, create(:store_manager))
   store_admin = Permission.granted?(:controller, :action, create(:store_admin))
platform_admin = Permission.granted?(:controller, :action, create(:platform_admin))

        expect([store_manager, platform_admin]).to all(be true)
        expect([user, visitor, store_admin]).to all(be false)
      end
    end
    context 'for namespaced controllers' do
      it 'works just fine' do
        stub_config({ "namespace/controller": { action: Permission::PUBLIC } })
        granted = Permission.granted?(:"namespace/controller", :action, nil)
        expect(granted).to be(true)
      end
    end

    # UserRole.exists?(user: user, store: store)
    # user.user_roles.exists?(store: store, role: Role.store_admin)

    describe 'assumes the worst' do
      it 'for missing controllers' do
        stub_config({ misspelled_controller: { action: Permission::PUBLIC } })
        refute Permission.granted?(:controller, :action, create(:platform_admin))
      end
      it 'for missing actions' do
        stub_config({ controller: { misspelled_action: Permission::PUBLIC }})
        refute Permission.granted?(:controller, :action, create(:platform_admin))
      end
    end

    def stub_config(mock)
      allow_any_instance_of(Permission).to receive(:permitted).and_return(mock)
    end
  end
end
