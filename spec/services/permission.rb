require 'rails_helper'

describe Permission do
  describe '::granted?' do

    context 'for public actions' do
      it 'returns true any user' do
        stub_config({ foo: { bar: true }})
        visitor = Permission.granted?(:foo, :bar, nil)
           user = Permission.granted?(:foo, :bar, create(:user, first_name: 'a'))
  store_manager = Permission.granted?(:foo, :bar, create(:store_manager, first_name: 'b'))
    store_admin = Permission.granted?(:foo, :bar, create(:store_admin, first_name: 'c'))
 platform_admin = Permission.granted?(:foo, :bar, create(:platform_admin, first_name: 'd'))

        expect([visitor, user, store_manager, store_admin, platform_admin]).to all(be true)
      end
    end
    context 'for private actions' do
      it 'returns true only for specified roles' do
        stub_config({ foo: { bar: %i{ store_manager platform_admin } }})
       visitor = Permission.granted?(:foo, :bar, nil)
          user = Permission.granted?(:foo, :bar, create(:user, first_name: 'e'))
 store_manager = Permission.granted?(:foo, :bar, create(:store_manager, first_name: 'f'))
   store_admin = Permission.granted?(:foo, :bar, create(:store_admin, first_name: 'g'))
platform_admin = Permission.granted?(:foo, :bar, create(:platform_admin, first_name: 'h'))
        #
        expect([store_manager, platform_admin]   ).to all(be true)
        expect([user, visitor, store_admin]).to all(be false)
        #
      end
    end

    # UserRole.exists?(user: user, store: store)
    # user.user_roles.exists?(store: store, role: Role.store_admin)

    describe 'assumes the worst' do
      it 'for missing controllers' do
        stub_config({ xfoo: { bar: true }})
        refute Permission.granted?(:foo, :bar, create(:platform_admin))
      end
      it 'for missing actions' do
        stub_config({ foo: { xbar: true }})
        refute Permission.granted?(:foo, :bar, create(:platform_admin))
      end
      it 'for errors' do
        permission = Permission.new(:foo, :bar, nil)
        expect{ permission.user_has_role_in?(nil) }.to raise_error(TypeError)

        expect(Permission.granted?(:foo, :bar, nil)).to be(false)
      end
    end

    def stub_config(mock)
      allow_any_instance_of(Permission).to receive(:permitted).and_return(mock)
    end
  end
end
