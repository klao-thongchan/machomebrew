# typed: strict
# frozen_string_literal: true

module OS
  module Linux
    module Cask
      module Installer
        private

        extend T::Helpers

        requires_ancestor { ::Cask::Installer }

        sig { void }
        def check_stanza_os_requirements
          return if artifacts.all?(::Cask::Artifact::Font)

          install_artifacts = artifacts.reject { |artifact| artifact.instance_of?(::Cask::Artifact::Zap) }
          return if install_artifacts.all? do |artifact|
            artifact.is_a?(::Cask::Artifact::Binary) ||
            artifact.is_a?(::Cask::Artifact::ShellCompletion) ||
            artifact.is_a?(::Cask::Artifact::Artifact) ||
            artifact.is_a?(::Cask::Artifact::Manpage)
          end

          raise ::Cask::CaskError, "macOS is required for this software."
        end
      end
    end
  end
end

Cask::Installer.prepend(OS::Linux::Cask::Installer)
