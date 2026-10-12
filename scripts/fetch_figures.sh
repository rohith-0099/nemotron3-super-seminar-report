#!/usr/bin/env bash
# Download the arXiv source of every reference paper into refs/<ID>/ and copy
# the figures used by the report into report/figures/.
# refs/ is not committed; run this script to re-create it.
set -euo pipefail
cd "$(dirname "$0")/.."

IDS="2604.12374 2512.20856 2512.20848 2601.18089 2509.25149 2504.03624
     2508.14444 2406.07887 2312.00752 2405.21060 2403.19887 2404.19737"

for id in $IDS; do
  if [ ! -d "refs/$id" ]; then
    mkdir -p "refs/$id"
    curl -sSL -A "Mozilla/5.0" -o "refs/$id/src.bin" "https://arxiv.org/src/$id"
    tar xzf "refs/$id/src.bin" -C "refs/$id"
    rm "refs/$id/src.bin"
    sleep 3   # be polite to arXiv
  fi
done

F=report/figures
copy() { cp "refs/$1" "$F/$2"; }

# Nemotron 3 Super (arXiv:2604.12374)
copy 2604.12374/figures/superv3.pdf                          n3s-fig01-accuracy-throughput.pdf
copy 2604.12374/figures/super-pattern.pdf                    n3s-fig02-layer-pattern.pdf
copy 2604.12374/figures/standard_moe.png                     n3s-fig03a-standard-moe.png
copy 2604.12374/figures/latent_moe.png                       n3s-fig03b-latent-moe.png
copy 2604.12374/figures/mtp_ar_comparison_unconditional.pdf  n3s-fig04-mtp-acceptance.pdf
copy 2604.12374/figures/mtp_trtllm_perf.png                  n3s-fig05-mtp-throughput.png
copy 2604.12374/figures/nvfp4_num_zeros_in_nano_during_training.pdf n3s-fig07-nvfp4-zero-grads.pdf
copy 2604.12374/figures/nvfp4_healing_super.pdf              n3s-fig09-nvfp4-healing.pdf
copy 2604.12374/figures/super-phase1.pdf                     n3s-fig10a-phase1-blend.pdf
copy 2604.12374/figures/super-phase2.pdf                     n3s-fig10b-phase2-blend.pdf
copy 2604.12374/figures/avg_benchmark.pdf                    n3s-fig11-checkpoint-merge.pdf
copy 2604.12374/figures/posttraining-stages.pdf              n3s-fig12-posttraining-stages.pdf
copy 2604.12374/figures/super_sft_blend.jpg                  n3s-fig16-sft-blend.jpg
# Mamba (2312.00752) and Mamba-2 (2405.21060)
copy 2312.00752/fig/selection.pdf                            mamba-fig01-selective-ssm.pdf
copy 2312.00752/fig/architecture.pdf                         mamba-fig03-block.pdf
copy 2405.21060/fig/architecture_2.pdf                       mamba2-fig06-block.pdf
# Empirical study of Mamba-based LMs (2406.07887)
copy 2406.07887/figures/percentage_attention.pdf             empirical-fig04-attention-ratio.pdf
copy 2406.07887/figures/3t_mmlu_vs_time.pdf                  empirical-fig06-mmlu.pdf
# Nemotron-H (2504.03624)
copy 2504.03624/figures/nemotron-h-pattern.pdf               nemotronh-fig02-layer-pattern.pdf
copy 2504.03624/figures/mmlu_pro_vs_throughput_larger_models.pdf nemotronh-fig01-throughput.pdf
# Nemotron 3 Nano (2512.20848)
copy 2512.20848/figures/nanov3_introfig.pdf                  nano3-fig01-accuracy-throughput.pdf
copy 2512.20848/figures/pattern.pdf                          nano3-fig02-layer-pattern.pdf
copy 2512.20848/figures/rlvr_compare_curriculum.pdf          nano3-fig07-rl-curriculum.pdf
# Jamba (2403.19887), Multi-token prediction (2404.19737)
copy 2403.19887/figures/jamba-arch.pdf                       jamba-fig01-block.pdf
copy 2404.19737/img/main_fig_col.png                         mtp-fig01-overview.png
# NVFP4 pretraining (2509.25149), LatentMoE (2601.18089)
copy 2509.25149/fig_nvfp4_tensor.pdf                         nvfp4-fig01-format.pdf
copy 2509.25149/fig_val_loss_12B.pdf                         nvfp4-fig02-val-loss.pdf
copy 2601.18089/figures/8B_val_loss.png                      latentmoe-fig06-95b-val-loss.png

echo "Figures copied to $F"
