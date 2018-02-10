require 'rails_helper'

describe Permission do
  describe '::granted?' do

    context 'for public actions' do
      it 'returns true any user' do
        stub_config({ Object: { action: true }})
        visitor = Permission.granted?(Object, :action, nil)
           user = Permission.granted?(Object, :action, create(:user))
  store_manager = Permission.granted?(Object, :action, create(:store_manager))
    store_admin = Permission.granted?(Object, :action, create(:store_admin))
 platform_admin = Permission.granted?(Object, :action, create(:platform_admin))

        expect([visitor, user, store_manager, store_admin, platform_admin]).to all(be true)
      end
    end
    context 'for private actions' do
      it 'returns true only for specified roles' do
        stub_config({ Object: { action: %i{ store_manager platform_admin } }})
       visitor = Permission.granted?(Object, :action, nil)
          user = Permission.granted?(Object, :action, create(:user))
 store_manager = Permission.granted?(Object, :action, create(:store_manager))
   store_admin = Permission.granted?(Object, :action, create(:store_admin))
platform_admin = Permission.granted?(Object, :action, create(:platform_admin))
        #
        expect([store_manager, platform_admin]   ).to all(be true)
        expect([user, visitor, store_admin]).to all(be false)
        #
      end
    end
    context 'for namespaced controllers' do
      it 'works just fine' do
        stub_config({ "Admin::DashboardsController": true })
        granted = Permission.granted?(Admin::DashboardsController, :action, nil)
      end
    end

    # UserRole.exists?(user: user, store: store)
    # user.user_roles.exists?(store: store, role: Role.store_admin)

    describe 'assumes the worst' do
      it 'for missing controllers' do
        stub_config({})
        refute Permission.granted?(Object, :action, create(:platform_admin))
      end
      it 'for missing actions' do
        stub_config({ Object: { misspelled_action: true }})
        refute Permission.granted?(Object, :action, create(:platform_admin))
      end
      it 'for errors' do
        permission = Permission.new(Object, :action, nil)
        expect{ permission.user_has_role_in?(nil) }.to raise_error(TypeError)
        expect(Permission.granted?(Object, :action, nil)).to be(false)
      end
    end

    def stub_config(mock)
      allow_any_instance_of(Permission).to receive(:permitted).and_return(mock)
    end
  end
end
